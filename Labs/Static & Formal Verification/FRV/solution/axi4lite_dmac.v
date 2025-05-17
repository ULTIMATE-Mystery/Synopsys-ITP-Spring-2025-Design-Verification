/*
 axi4lite_dmac
 Simple Memory to Memoty DMAC
 
 Control & Status regsiters
 LEN: bit width of TLENGTH between 1 to 8

 PADDR=0x00 : Interrupt control & status register
 Interrupt will be asserted when DMA Completes
 Interrupt will be cleared when cleared by register or new DMA starts
 [31:31]   WO INTRCLR - Interrupt clear    1: Clear    0: Not affect
 [1:1]     RO INTRSTS - Interrupt satus    1: Asserted 0: Not asserted
 [0:0]     RW INTRENB - Interrupt control  1: Enable   0: Disable

 PADDR=0x04 : DMA Control
 [31:31]   WO KICKDMA - kick DMA by setting 1
                        cleared when DMA completes
 [LEN-1:0] RW TLENGTH - specify transfer length

 PADDR=0x08 : Status
 [31:31]   RO DMA_ACTIVE - 1: indicates DMA is active 0: indicates not active
 [LEN-1:0] RO CUR_LENGTH - current transferred length starting from 0

 PADDR=0x10 : Source Start Address
 [31:2]    RW SRCADDR - specify source start address

 PADDR=0x14 : Current Source Address
 [31:2]    RO CUR_SRCADDR - indicates current source address

 PADDR=0x18 : Destination Start Address
 [31:2]    RW DSTADDR - specify destination start address

 PADDR=0x1C : Current Destination Address
 [31:2]    RO CUR_DSTADDR - indicates current destination address

 */

module axi4lite_dmac
  #(parameter ADDR_WIDTH  = 6,
    parameter DATA_WIDTH  = 32,
    parameter XADDR_WIDTH = 32,
    parameter XDATA_WIDTH = 32,
    parameter XSTRB_WIDTH = 4,
    parameter TRANS_LEN   = 8,
    parameter MAX_OUTS    = 4)
  (input logic                    CLK,
   input logic 			  RSTN,
   input logic [ADDR_WIDTH-1:0]   RGADDR,
   input logic 			  RGCSEL,
   input logic 			  RGWRITE,
   output logic 		  RGBUSY,
   input logic [DATA_WIDTH-1:0]   RGWDATA,
   output logic [DATA_WIDTH-1:0]  RGRDATA,
   output logic 		  AWVALID,
   input logic 			  AWREADY,
   output logic [XADDR_WIDTH-1:0] AWADDR,
   output logic [2:0] 		  AWPROT,
   output logic 		  WVALID,
   input logic 			  WREADY,
   output logic [XDATA_WIDTH-1:0] WDATA,
   output logic [XSTRB_WIDTH-1:0] WSTRB,
   input logic 			  BVALID,
   output logic 		  BREADY,
   input logic [1:0] 		  BRESP,
   output logic 		  ARVALID,
   input logic 			  ARREADY,
   output logic [XADDR_WIDTH-1:0] ARADDR,
   output logic [2:0] 		  ARPROT,
   input logic 			  RVALID,
   output logic 		  RREADY,
   input logic [XDATA_WIDTH-1:0]  RDATA,
   input logic [1:0] 		  RRESP,
   output logic 		  INTR);

   //localparam LWIDTH   = $clog2(TRANS_LEN);
   localparam REG_INTR = 'h00;
   localparam REG_CTRL = 'h04;
   localparam REG_STTS = 'h08;
   localparam REG_SRCA = 'h10;
   localparam REG_CSRC = 'h14;
   localparam REG_DSTA = 'h18;
   localparam REG_CDST = 'h1C;
   localparam RD_IDLE  = 2'b00;
   localparam RD_RQST  = 2'b01;
   localparam RD_WAIT  = 2'b10;
   localparam RD_DONE  = 2'b11;
   localparam WR_IDLE  = 3'b000;
   localparam WR_RQST  = 3'b001;
   localparam WR_WTAD  = 3'b010;
   localparam WR_WTDT  = 3'b011;
   localparam WR_FIFO  = 3'b100;
   localparam WR_RESP  = 3'b101;

   logic [TRANS_LEN-1:0]   set_length, src_length;
   logic [TRANS_LEN-1:0]   dst_length, bresp_cnts;
   logic 		   kick_dma, dma_done;
   logic [XADDR_WIDTH-3:0] src_addr, dst_addr;
   logic [XADDR_WIDTH-3:0] cur_srca, cur_dsta;
   logic [DATA_WIDTH-1:0]  o_rdata;
   logic [1:0] 		   rd_state;
   logic [2:0] 		   wr_state;
   logic 		   o_arvalid;
   logic 		   o_awvalid, o_wvalid;
   logic [XDATA_WIDTH-1:0] o_wdata;
   logic 		   o_intr;
   logic 		   fifo_empty, fifo_full;
   logic 		   fifo_wren,  fifo_rden;
   logic [XDATA_WIDTH-1:0] fifo_wdata, fifo_rdata;
   logic 		   intr_en;
   logic 		   s_active;
   logic 		   decerr;
   logic 		   reg_wr, reg_rd;

   assign reg_wr  = RGCSEL &  RGWRITE;
   assign reg_rd  = RGCSEL & ~RGWRITE;
   assign decerr  = (RGADDR>='h20);
   assign RGBUSY  = s_active;
   assign RGRDATA = o_rdata;

   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 o_rdata <= 'b0;
      end else begin
	 if (reg_rd) begin
	    case (RGADDR)
	      REG_INTR : o_rdata <= {{(DATA_WIDTH-2){1'b0}}, o_intr, intr_en};
	      REG_CTRL : o_rdata <= {s_active, {(DATA_WIDTH-TRANS_LEN-1){1'b0}}, set_length};
	      REG_STTS : o_rdata <= {s_active, {(DATA_WIDTH-TRANS_LEN-1){1'b0}}, dst_length};
	      REG_SRCA : o_rdata <= {src_addr, 2'b0};
	      REG_CSRC : o_rdata <= {cur_srca, 2'b0};
	      REG_DSTA : o_rdata <= {dst_addr, 2'b0};
	      REG_CDST : o_rdata <= {cur_dsta, 2'b0};
	      default  : o_rdata <= 'd0;
	    endcase // case (RGADDR)
	 end
      end
   end

   assign intr_clr = reg_wr & ~s_active & (RGADDR==REG_INTR) & (RGWDATA[31]==1'b1);
   assign kick_dma = reg_wr & ~s_active & (RGADDR==REG_CTRL) & (RGWDATA[31]==1'b1);
   assign dma_done = ((wr_state==WR_FIFO && dst_length==set_length) || (wr_state==WR_RESP)) &
		     BVALID & ((bresp_cnts+'d1)==set_length);

   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 intr_en    <= 1'b0;
	 set_length <= 'd0;
	 src_addr   <= 'b0;
	 dst_addr   <= 'b0;
      end else begin
	 if (s_active==1'b0 && reg_wr==1'b1 && decerr==1'b0) begin
	    case (RGADDR)
	      REG_INTR : begin
		 intr_en <= RGWDATA[0];
	      end
	      REG_CTRL : begin
		 set_length <= RGWDATA[TRANS_LEN-1:0];
	      end
	      REG_SRCA : src_addr <= RGWDATA[XADDR_WIDTH-1:2];
	      REG_DSTA : dst_addr <= RGWDATA[XADDR_WIDTH-1:2];
	    endcase // case (ADDR)
	 end
      end
   end

   // DMAC Read Address FSM
   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 o_arvalid  <= 1'b0;
	 src_length <=  'd0;
	 rd_state   <= RD_IDLE;
      end else begin
	 case (rd_state)
	   RD_IDLE : begin
	      if (s_active==0 && kick_dma==1) begin
		 o_arvalid  <= 1'b1;
	         src_length <=  'd0;
		 rd_state   <= RD_RQST;
	      end
	   end
	   RD_RQST : begin
	      if (ARREADY) begin
		 src_length <= src_length + 'd1;
		 if ((src_length+'d1)>=set_length) begin
		    o_arvalid <= 1'b0;
		    rd_state  <= RD_DONE;
		 end else begin
		    if (fifo_full==1'b1) begin
		       o_arvalid <= 1'b0;
		       rd_state  <= RD_WAIT;
		    end
		 end
	      end
	   end // case: RD_RQST
	   RD_WAIT : begin
	      if (fifo_full==1'b0) begin
		 o_arvalid <= 1'b1;
		 rd_state <= RD_RQST;
	      end
	   end
	   RD_DONE : begin
	      if (dma_done==1'b1) begin
		 rd_state <= RD_IDLE;
	      end
	   end
	 endcase // case (rd_state)
      end
   end // always @ (posedge CLK or negedge RSTN)
   assign cur_srca   = (src_addr + src_length);
   assign ARVALID    = o_arvalid;
   assign ARADDR     = {cur_srca, 2'b0};
   assign ARPROT     = 3'b0;
   assign RREADY     = ~fifo_full;
   assign fifo_wren  = RVALID & ~fifo_full;
   assign fifo_rden  = o_wvalid & WREADY;
   assign fifo_wdata = RDATA;

   // DMAC Write FSM
   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 o_awvalid  <= 1'b0;
	 o_wvalid   <= 1'b0;
	 o_wdata    <= 'b0;
	 dst_length <= 'd0;
	 wr_state   <= WR_IDLE;
      end else begin
	 case (wr_state)
	   WR_IDLE : begin
	      if (fifo_empty==1'b0 && s_active==1'b1) begin
		 o_awvalid  <= 1'b1;
		 o_wvalid   <= 1'b1;
		 o_wdata    <= fifo_rdata;
		 dst_length <= 'd0;
		 wr_state   <= WR_RQST;
	      end
	   end
	   WR_RQST : begin
	      if (AWREADY && WREADY) begin
		 dst_length <= dst_length + 'd1;
		 o_awvalid  <= 1'b0;
		 o_wvalid   <= 1'b0;
		 wr_state   <= WR_FIFO;
	      end else if (AWREADY && !WREADY) begin
		 o_awvalid <= 1'b0;
		 wr_state  <= WR_WTDT;
	      end else if (!AWREADY && WREADY) begin
		 o_wvalid  <= 1'b0;
		 wr_state  <= WR_WTAD;
	      end
	   end
	   WR_WTAD : begin
	      if (AWREADY) begin
		 dst_length <= dst_length + 'd1;
		 o_awvalid  <= 1'b0;
		 o_wvalid   <= 1'b0;
		 wr_state   <= WR_FIFO;
	      end
	   end
	   WR_WTDT : begin
	      if (WREADY) begin
		 dst_length <= dst_length + 'd1;
		 o_awvalid  <= 1'b0;
		 o_wvalid   <= 1'b0;
		 wr_state   <= WR_FIFO;
	      end
	   end
	   WR_FIFO : begin
	      if (dst_length==set_length) begin
		 if (BVALID && (bresp_cnts+'d1)==set_length) begin
		    wr_state <= WR_IDLE;
		 end else begin
		    wr_state <= WR_RESP;
		 end
	      end else if (fifo_empty==1'b0) begin
		 o_awvalid <= 1'b1;
		 o_wvalid  <= 1'b1;
		 o_wdata   <= fifo_rdata;
		 wr_state  <= WR_RQST;
	      end
	   end
	   WR_RESP : begin
	      if (BVALID && (bresp_cnts+'d1)==set_length) begin
		 wr_state <= WR_IDLE;
	      end
	   end
	 endcase // case (wr_state)
      end
   end
   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 bresp_cnts <= 'd0;
      end else begin
	 if (kick_dma) begin
	    bresp_cnts <= 'd0;
	 end else if (BVALID) begin
	    bresp_cnts <= bresp_cnts + 'd1;
	 end
      end
   end
   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 s_active <= 1'b0;
	 o_intr   <= 1'b0;
      end else begin
	 if (s_active==1'b0 && kick_dma==1'b1) begin
	    s_active <= 1'b1;
	    o_intr   <= 1'b0;
	 end else if (s_active==1'b1 && dma_done) begin
	    s_active <= 1'b0;
	    o_intr   <= intr_en;
	 end else if (intr_clr) begin
	    o_intr   <= 1'b0;
	 end
      end
   end

   assign cur_dsta = (dst_addr + dst_length);
   assign AWVALID  = o_awvalid;
   assign AWADDR   = {cur_dsta, 2'b0};
   assign AWPROT   = 3'b0;
   assign WVALID   = o_wvalid;
   assign WDATA    = o_wdata;
   assign WSTRB    = '1;
   assign BREADY   = 1'b1;
   assign INTR     = o_intr;

   axi4lite_dmac_fifo
     #(.DEPTH (MAX_OUTS),
       .WIDTH (XDATA_WIDTH))
   fifo
     (.CLK   (CLK),
      .RSTN  (RSTN),
      .WREN  (fifo_wren),
      .RDEN  (fifo_rden),
      .WDATA (RDATA),
      .RDATA (fifo_rdata),
      .EMPTY (fifo_empty),
      .FULL  (fifo_full));

endmodule // axi4lite_dmac
