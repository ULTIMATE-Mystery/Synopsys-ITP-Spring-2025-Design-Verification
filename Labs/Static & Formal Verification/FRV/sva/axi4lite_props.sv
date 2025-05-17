// AGENT_TYPE
// 0: MASTER, 1: SLAVE, 2: MONITOR, 3: CONSTRAINT

module axi4lite_props
  #(parameter AGENT_TYPE    =  0,
    parameter ENABLE_ASSERT =  1,
    parameter ENABLE_ASSUME =  1,
    parameter ADDR_WIDTH    = 32,
    parameter DATA_WIDTH    = 32,
    parameter STRB_WIDTH    =  4,
    parameter MAX_OUTS      =  4)
  (input logic                  ACLK,
   input logic 			ARESETn,
   input logic 			AWVALID,
   input logic 			AWREADY,
   input logic [ADDR_WIDTH-1:0] AWADDR,
   input logic [2:0] 		AWPROT,
   input logic 			WVALID,
   input logic 			WREADY,
   input logic [DATA_WIDTH-1:0] WDATA,
   input logic [STRB_WIDTH-1:0] WSTRB,
   input logic 			BVALID,
   input logic 			BREADY,
   input logic [1:0] 		BRESP,
   input logic 			ARVALID,
   input logic 			ARREADY,
   input logic [ADDR_WIDTH-1:0] ARADDR,
   input logic [2:0] 		ARPROT,
   input logic 			RVALID,
   input logic 			RREADY,
   input logic [DATA_WIDTH-1:0] RDATA,
   input logic [1:0] 		RRESP);

   localparam MAX_OUTS_WIDTH = $clog2(MAX_OUTS+1);
   localparam MASTER     = 0;
   localparam SLAVE      = 1;
   localparam MONITOR    = 2;
   localparam CONSTRAINT = 3;

   bit [MAX_OUTS_WIDTH-1:0] wa_cnts, wd_cnts, wr_cnts, rd_cnts;

   always @(posedge ACLK or negedge ARESETn) begin
      if (!ARESETn) begin
	 wa_cnts <= 'd0;
	 wd_cnts <= 'd0;
	 wr_cnts <= 'd0;
	 rd_cnts <= 'd0;
      end else begin
	 wa_cnts <= wa_cnts + (AWVALID & AWREADY) - (BVALID & BREADY);
	 wd_cnts <= wd_cnts + (AWVALID & AWREADY) - (WVALID & WREADY);
	 wr_cnts <= wr_cnts + ( WVALID &  WREADY) - (BVALID & BREADY);
	 rd_cnts <= rd_cnts + (ARVALID & ARREADY) - (RVALID & RREADY);
      end
   end

   property p_sig_stable(vld, rdy, sig);
      @(posedge ACLK) disable iff (!ARESETn)
	(vld && !rdy) |=> $stable(sig);
   endproperty
   property p_read_stable(sig);
      @(posedge ACLK) disable iff (!ARESETn)
	(RVALID && !RREADY) |=> $stable(sig);
   endproperty
   property p_wvalid_allowed;
      @(posedge ACLK) disable iff (!ARESETn)
	WVALID |-> (wd_cnts>'d0 || AWVALID);
   endproperty
   property p_bvalid_allowed;
      @(posedge ACLK) disable iff (!ARESETn)
	BVALID |-> (wa_cnts>'d0 && wr_cnts>'d0);
   endproperty
   property p_rvalid_allowed;
      @(posedge ACLK) disable iff (!ARESETn)
	RVALID |-> (rd_cnts>'d0);
   endproperty

generate
   if (AGENT_TYPE==MASTER) begin : CFG_MASTER
      if (ENABLE_ASSUME==1) begin
	 asm_awvalid_stable : assume property(p_sig_stable(AWVALID, AWREADY, AWVALID));
	 asm_awaddr_stable  : assume property(p_sig_stable(AWVALID, AWREADY, AWADDR));
	 asm_awprot_stable  : assume property(p_sig_stable(AWVALID, AWREADY, AWPROT));
	 asm_wvalid_stable  : assume property(p_sig_stable( WVALID,  WREADY,  WVALID));
	 asm_wdata_stable   : assume property(p_sig_stable( WVALID,  WREADY,  WDATA));
	 asm_wstrb_stable   : assume property(p_sig_stable( WVALID,  WREADY,  WSTRB));
	 asm_wvalid_allowed : assume property(p_wvalid_allowed);
      end
      if (ENABLE_ASSERT==1) begin
	 ast_bvalid_stable  : assert property(p_sig_stable( BVALID,  BREADY,  BVALID));
	 ast_bresp_stable   : assert property(p_sig_stable( BVALID,  BREADY,  BRESP));
	 ast_rvalid_stable  : assert property(p_sig_stable( RVALID,  RREADY,  RVALID));
	 ast_rresp_stable   : assert property(p_sig_stable( RVALID,  RREADY,  RRESP));
	 ast_rdata_stable   : assert property(p_sig_stable( RVALID,  RREADY,  RDATA));
	 ast_bvalid_allowed : assert property(p_bvalid_allowed);
	 ast_rvalid_allowed : assert property(p_rvalid_allowed);
      end
   end : CFG_MASTER
endgenerate
generate
   if (AGENT_TYPE==SLAVE) begin : CFG_SLAVE
      if (ENABLE_ASSERT==1) begin
	 ast_awvalid_stable : assert property(p_sig_stable(AWVALID, AWREADY, AWVALID));
	 ast_awaddr_stable  : assert property(p_sig_stable(AWVALID, AWREADY, AWADDR));
	 ast_awprot_stable  : assert property(p_sig_stable(AWVALID, AWREADY, AWPROT));
	 ast_wvalid_stable  : assert property(p_sig_stable( WVALID,  WREADY,  WVALID));
	 ast_wdata_stable   : assert property(p_sig_stable( WVALID,  WREADY,  WDATA));
	 ast_wstrb_stable   : assert property(p_sig_stable( WVALID,  WREADY,  WSTRB));
	 ast_wvalid_allowed : assert property(p_wvalid_allowed);
      end
      if (ENABLE_ASSUME==1) begin
	 asm_bvalid_stable  : assume property(p_sig_stable(BVALID, BREADY, BVALID));
	 asm_bresp_stable   : assume property(p_sig_stable(BVALID, BREADY, BRESP));
	 asm_rvalid_stable  : assume property(p_sig_stable(RVALID, RREADY, RVALID));
	 asm_rresp_stable   : assume property(p_sig_stable(RVALID, RREADY, RRESP));
	 asm_rdata_stable   : assume property(p_sig_stable(RVALID, RREADY, RDATA));
	 asm_bvalid_allowed : assume property(p_bvalid_allowed);
	 asm_rvalid_allowed : assume property(p_rvalid_allowed);
      end
   end : CFG_SLAVE
endgenerate
generate
   if (AGENT_TYPE==MONITOR) begin : CFG_MONITOR
      ast_awvalid_stable : assert property(p_sig_stable(AWVALID, AWREADY, AWVALID));
      ast_awaddr_stable  : assert property(p_sig_stable(AWVALID, AWREADY, AWADDR));
      ast_awprot_stable  : assert property(p_sig_stable(AWVALID, AWREADY, AWPROT));
      ast_wvalid_stable  : assert property(p_sig_stable( WVALID,  WREADY,  WVALID));
      ast_wdata_stable   : assert property(p_sig_stable( WVALID,  WREADY,  WDATA));
      ast_wstrb_stable   : assert property(p_sig_stable( WVALID,  WREADY,  WSTRB));
      ast_wvalid_allowed : assert property(p_wvalid_allowed);
      ast_bvalid_stable  : assert property(p_sig_stable(BVALID, BREADY, BVALID));
      ast_bresp_stable   : assert property(p_sig_stable(BVALID, BREADY, BRESP));
      ast_rvalid_stable  : assert property(p_sig_stable(RVALID, RREADY, RVALID));
      ast_rresp_stable   : assert property(p_sig_stable(RVALID, RREADY, RRESP));
      ast_rdata_stable   : assert property(p_sig_stable(RVALID, RREADY, RDATA));
      ast_bvalid_allowed : assert property(p_bvalid_allowed);
      ast_rvalid_allowed : assert property(p_rvalid_allowed);
   end : CFG_MONITOR
endgenerate
generate
   if (AGENT_TYPE==CONSTRAINT) begin : CFG_CONSTRAINT
      asm_awvalid_stable : assume property(p_sig_stable(AWVALID, AWREADY, AWVALID));
      asm_awaddr_stable  : assume property(p_sig_stable(AWVALID, AWREADY, AWADDR));
      asm_awprot_stable  : assume property(p_sig_stable(AWVALID, AWREADY, AWPROT));
      asm_wvalid_stable  : assume property(p_sig_stable( WVALID,  WREADY,  WVALID));
      asm_wdata_stable   : assume property(p_sig_stable( WVALID,  WREADY,  WDATA));
      asm_wstrb_stable   : assume property(p_sig_stable( WVALID,  WREADY,  WSTRB));
      asm_wvalid_allowed : assume property(p_wvalid_allowed);
      asm_bvalid_stable  : assume property(p_sig_stable(BVALID, BREADY, BVALID));
      asm_bresp_stable   : assume property(p_sig_stable(BVALID, BREADY, BRESP));
      asm_rvalid_stable  : assume property(p_sig_stable(RVALID, RREADY, RVALID));
      asm_rresp_stable   : assume property(p_sig_stable(RVALID, RREADY, RRESP));
      asm_rdata_stable   : assume property(p_sig_stable(RVALID, RREADY, RDATA));
      asm_bvalid_allowed : assume property(p_bvalid_allowed);
      asm_rvalid_allowed : assume property(p_rvalid_allowed);
   end : CFG_CONSTRAINT
endgenerate

endmodule // axi4lite_props
