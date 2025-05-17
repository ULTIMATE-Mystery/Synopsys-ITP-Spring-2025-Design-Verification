/*
   generate request based on each burst beat
    regardless of burst type
 */

module ahb_if
  (hclk,
   hresetn,
   haddr,
   htrans,
   hwrite,
   hsize,
   hburst,
   hsel,
   hready,
   hwdata,
   hrdata,
   hreadyout,
   hresp,
   s_addr,
   s_wrreq,
   s_wstrb,
   s_wdata,
   s_rdreq,
   s_rdata,
   s_ack,
   s_error);

   parameter ADDR_WIDTH = 32;
   parameter DATA_WIDTH = 64;
   parameter STRB_WIDTH = (DATA_WIDTH/8);

   // Clock
   input                   hclk;
   // Reset
   input                   hresetn;
   // AHB Bus signals
   input [ADDR_WIDTH-1:0]  haddr;
   input [1:0]             htrans;
   input                   hwrite;
   input [2:0]             hsize;
   input [2:0]             hburst;
   input                   hsel;
   input                   hready;
   input [DATA_WIDTH-1:0]  hwdata;
   output [DATA_WIDTH-1:0] hrdata;
   output                  hreadyout;
   output                  hresp;
   // internal signals
   output [ADDR_WIDTH-1:0] s_addr;
   output                  s_wrreq;
   output [STRB_WIDTH-1:0] s_wstrb;
   output [DATA_WIDTH-1:0] s_wdata;
   output                  s_rdreq;
   input [DATA_WIDTH-1:0]  s_rdata;
   input                   s_ack;
   input                   s_error;

   //----------------------
   // HTRANS
   //   00: IDLE
   //   01: BUSY
   //   10: NONSEQ
   //   11: SEQ
   // HBURST
   //   000: SINGLE
   //   001: INCR
   //   010: WRAP4
   //   011: INCR4
   //   100: WRAP8
   //   101: INCR8
   //   110: WRAP16
   //   111: INCR16
   // HSIZE
   //   000: Byte
   //   001: Halfword
   //   010: Word
   //   011:  (64 bits)
   //   100: 4-word line
   //   101: 8-word line
   //   110:  (512 bits)
   //   111:  (1024 bits)
   //----------------------
   //---------------------------------------
   // AHB Bus related signals
   //---------------------------------------
   localparam LAD_MSB = (DATA_WIDTH>=1024)? 6:
                        (DATA_WIDTH>=512)?  5:
                        (DATA_WIDTH>=256)?  4:
                        (DATA_WIDTH>=128)?  3:
                        (DATA_WIDTH>=64)?   2:
                        (DATA_WIDTH>=32)?   1:0;
   
   // state type definitions
   localparam [1:0] ST_IDLE  = 2'b00;
   localparam [1:0] ST_WRITE = 2'b01;
   localparam [1:0] ST_READ  = 2'b10;
   localparam [1:0] ST_RESP  = 2'b11;
   // AHB FSM
   reg [1:0] ahb_state;
   // AHB Read  Data
   reg [DATA_WIDTH-1:0] o_hrdata;
   // AHB HRESP
   reg                  o_hresp;
   // AHB HREADY
   reg                  o_hready;
   // AHB write/read request enable
   reg                  o_wrreq;
   reg                  o_rdreq;
   reg [ADDR_WIDTH-1:0] o_addr;
   reg [DATA_WIDTH-1:0] o_wdata;
   reg [STRB_WIDTH-1:0] o_wstrb, ahb_wstrb;

   function [STRB_WIDTH-1:0] get_ahb_strobe;
      input [2:0] size;
      input [6:0] ladd;
      case (size)
        3'b000 : get_ahb_strobe = 'h1 << ladd[LAD_MSB-1:0];
        3'b001 : get_ahb_strobe = 'h3 << ladd[LAD_MSB-1:0];
        3'b010 : get_ahb_strobe = 'hf << ladd[LAD_MSB-1:0];
        3'b011 : get_ahb_strobe = 'hff << ladd[LAD_MSB-1:0];
        3'b100 : get_ahb_strobe = 'hffff << ladd[LAD_MSB-1:0];
        3'b101 : get_ahb_strobe = 'hffffffff << ladd[LAD_MSB-1:0];
        3'b110 : get_ahb_strobe = 'hffffffffffffffff << ladd[LAD_MSB-1:0];
        3'b111 : get_ahb_strobe = 'hffffffffffffffffffffffffffffffff << ladd[LAD_MSB-1:0];
      endcase
   endfunction // get_ahb_strobe

   // AHB bus output signals
   assign hreadyout = o_hready;
   assign hrdata    = o_hrdata;
   assign hresp     = o_hresp;
   // Internal signals
   assign s_rdreq = o_rdreq;
   assign s_wrreq = o_wrreq;
   assign s_wdata = o_wdata;
   assign s_wstrb = o_wstrb;
   assign s_addr  = o_addr;

   always @(posedge hclk)
     if (!hresetn) begin
        o_wrreq   <= 1'b0;
        o_rdreq   <= 1'b0;
        o_addr    <=  'b0;
        o_wstrb   <=  'b0;
        o_wdata   <=  'b0;
        o_hready  <= 1'b1;
        o_hrdata  <=  'b0;
        o_hresp   <= 1'b0;
        ahb_state <= ST_IDLE;
     end else begin
        case (ahb_state)
          ST_IDLE : begin
             o_hrdata <=  'b0;
             o_hresp  <= 1'b0;
             if (htrans[1] && hsel && hready) begin
                o_addr <= haddr;
                if (!hwrite) begin
                   o_wrreq   <= 1'b0;
                   o_rdreq   <= 1'b1;
                   o_hready  <= 1'b0;
                   ahb_state <= ST_READ;
                end else begin
                   o_wrreq   <= 1'b1;
                   o_rdreq   <= 1'b0;
                   o_wstrb   <= ahb_wstrb;
                   o_wdata   <= hwdata;
                   o_hready  <= 1'b0;
                   ahb_state <= ST_WRITE;
                end
             end
          end
          ST_WRITE : begin
             if (s_ack && !s_error) begin
                o_wrreq   <= 1'b0;
                o_hready  <= 1'b1;
                o_hresp   <= 1'b0;
                ahb_state <= ST_IDLE;
             end else if (s_ack && s_error) begin
                o_wrreq   <= 1'b0;
                o_hready  <= 1'b0;
                o_hresp   <= 1'b1;
                ahb_state <= ST_RESP;
             end
          end
          ST_READ : begin
             if (s_ack && !s_error) begin
                o_rdreq   <= 1'b0;
                o_hready  <= 1'b1;
                o_hrdata  <= s_rdata;
                o_hresp   <= 1'b0;
                ahb_state <= ST_IDLE;
             end else if (s_ack && s_error) begin
                o_rdreq   <= 1'b0;
                o_hready  <= 1'b0;
                o_hrdata  <= s_rdata;
                o_hresp   <= 1'b1;
                ahb_state <= ST_RESP;
             end
          end
          ST_RESP : begin
             o_wrreq   <= 1'b0;
             o_rdreq   <= 1'b0;
             o_hready  <= 1'b1;
             ahb_state <= ST_IDLE;
          end
          default : begin
             o_wrreq   <= 1'b0;
             o_rdreq   <= 1'b0;
             o_wstrb   <=  'b0;
             o_wdata   <=  'b0;
             o_hready  <= 1'b1;
             o_hrdata  <=  'b0;
             o_hresp   <= 1'b0;
	     ahb_state <= ST_IDLE;
	  end
	endcase // case (ahb_state)
     end

endmodule // ahb_if
