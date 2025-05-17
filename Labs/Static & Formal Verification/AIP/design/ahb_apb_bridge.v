/*
   Generate request based on each burst beat
    regardless of burst type
   No write strobe in APB, so response with ERROR
    if access size is not bus width
 */

module ahb_apb_bridge
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
   psel,
   penable,
   paddr,
   pwrite,
   pwdata,
   prdata,
   pready,
   pslverr);

   parameter HADDR_WIDTH = 32;
   parameter PADDR_WIDTH = 30;
   parameter PSEL_WIDTH  =  4;
   parameter DATA_WIDTH  = 64;
   parameter STRB_WIDTH  = (DATA_WIDTH/8);

   // clock
   input                    hclk;
   // reset
   input                    hresetn;
   // AHB Bus signals
   input [HADDR_WIDTH-1:0]  haddr;
   input [1:0]              htrans;
   input                    hwrite;
   input [2:0]              hsize;
   input [2:0]              hburst;
   input                    hsel;
   input                    hready;
   input [DATA_WIDTH-1:0]   hwdata;
   output [DATA_WIDTH-1:0]  hrdata;
   output                   hreadyout;
   output                   hresp;
   // APB Bus signals
   output [PSEL_WIDTH-1:0]  psel;
   output 		    penable;
   output [PADDR_WIDTH-1:0] paddr;
   output 		    pwrite;
   output [DATA_WIDTH-1:0]  pwdata;
   input [DATA_WIDTH-1:0]   prdata;
   input 		    pready;
   input 		    pslverr;

   // internal signals
   wire [HADDR_WIDTH-1:0]   s_addr;
   wire 		    s_wrreq;
   wire [STRB_WIDTH-1:0]    s_wstrb;
   wire [DATA_WIDTH-1:0]    s_wdata;
   wire 		    s_rdreq;
   wire [DATA_WIDTH-1:0]    s_rdata;
   wire 		    s_ack;
   wire 		    s_error;

   ahb_if
     #(.ADDR_WIDTH (HADDR_WIDTH),
       .DATA_WIDTH (DATA_WIDTH),
       .STRB_WIDTH (STRB_WIDTH))
   ahb
     (.hclk      (hclk),
      .hresetn   (hresetn),
      .haddr     (haddr),
      .htrans    (htrans),
      .hwrite    (hwrite),
      .hsize     (hsize),
      .hburst    (hburst),
      .hsel      (hsel),
      .hready    (hready),
      .hwdata    (hwdata),
      .hrdata    (hrdata),
      .hreadyout (hreadyout),
      .hresp     (hresp),
      .s_addr    (s_addr),
      .s_wrreq   (s_wrreq),
      .s_wstrb   (s_wstrb),
      .s_wdata   (s_wdata),
      .s_rdreq   (s_rdreq),
      .s_rdata   (s_rdata),
      .s_ack     (s_ack),
      .s_error   (s_error));

   apb_if
     #(.HADDR_WIDTH (HADDR_WIDTH),
       .PADDR_WIDTH (PADDR_WIDTH),
       .PSEL_WIDTH  (PSEL_WIDTH),
       .DATA_WIDTH  (DATA_WIDTH),
       .STRB_WIDTH  (STRB_WIDTH))
   apb
     (.pclk      (hclk),
      .presetn   (hresetn),
      .psel      (psel),
      .penable   (penable),
      .paddr     (paddr),
      .pwrite    (pwrite),
      .pwdata    (pwdata),
      .prdata    (prdata),
      .pready    (pready),
      .pslverr   (pslverr),
      .s_addr    (s_addr),
      .s_wrreq   (s_wrreq),
      .s_wstrb   (s_wstrb),
      .s_wdata   (s_wdata),
      .s_rdreq   (s_rdreq),
      .s_rdata   (s_rdata),
      .s_ack     (s_ack),
      .s_error   (s_error));

endmodule // ahb_apb_bridge
