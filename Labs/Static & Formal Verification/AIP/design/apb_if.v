/*
   generate request based on each burst beat
    regardless of burst type
   No write strobe in APB, so response with ERROR
    if access size is not bus width
 */

module apb_if
  (pclk,
   presetn,
   psel,
   penable,
   paddr,
   pwrite,
   pwdata,
   prdata,
   pready,
   pslverr,
   s_addr,
   s_wrreq,
   s_wstrb,
   s_wdata,
   s_rdreq,
   s_rdata,
   s_ack,
   s_error);

   parameter HADDR_WIDTH = 32;
   parameter PADDR_WIDTH = 30;
   parameter PSEL_WIDTH  =  4;
   parameter DATA_WIDTH  = 64;
   parameter STRB_WIDTH  = (DATA_WIDTH/8);

   // clock
   input 		    pclk;
   // reset
   input 		    presetn;
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
   input [HADDR_WIDTH-1:0]  s_addr;
   input 		    s_wrreq;
   input [STRB_WIDTH-1:0]   s_wstrb;
   input [DATA_WIDTH-1:0]   s_wdata;
   input 		    s_rdreq;
   output [DATA_WIDTH-1:0]  s_rdata;
   output 		    s_ack;
   output 		    s_error;

   // state type definitions
   localparam [1:0] ST_IDLE = 2'b00;
   localparam [1:0] ST_RQST = 2'b01;
   localparam [1:0] ST_WAIT = 2'b10;

   // AHB FSM
   reg [1:0] 		   apb_state;
   // Internal signals
   reg [PSEL_WIDTH-1:0]    o_psel;
   reg 			   o_penable;
   reg [PADDR_WIDTH-1:0]   o_paddr;
   reg 			   o_pwrite;
   reg [DATA_WIDTH-1:0]    o_pwdata;
   reg [DATA_WIDTH-1:0]    o_rdata;
   reg 			   o_ack;
   reg 			   o_error;
   wire [PSEL_WIDTH-1:0]   act_psel;
   wire [HADDR_WIDTH-PADDR_WIDTH-1:0] upper_addr;

   assign psel    = o_psel;
   assign penable = o_penable;
   assign paddr   = o_paddr;
   assign pwrite  = o_pwrite;
   assign pwdata  = o_pwdata;
   assign s_rdata = o_rdata;
   assign s_ack   = o_ack;
   assign s_error = o_error;

   assign upper_addr = s_addr[HADDR_WIDTH-1:PADDR_WIDTH];
   assign act_psel   = 'b1 << upper_addr;

   always @(posedge pclk)
     if (!presetn) begin
	o_psel    <=  'b0;
	o_penable <= 1'b0;
	o_pwrite  <= 1'b0;
	o_paddr   <=  'b0;
	o_pwdata  <=  'b0;
	o_rdata   <=  'b0;
	o_ack     <= 1'b0;
	o_error   <= 1'b0;
	apb_state <= ST_IDLE;
     end else begin
	case (apb_state)
	  ST_IDLE : begin
	     if (s_rdreq) begin
		o_psel    <= act_psel;
		o_penable <= 1'b0;
		o_pwrite  <= 1'b0;
		o_paddr   <= s_addr;
		o_pwdata  <=  'b0;
		o_ack     <= 1'b0;
		o_error   <= 1'b0;
		apb_state <= ST_RQST;
	     end else if (s_wrreq && (&s_wstrb==1'b1)) begin
		o_psel    <= act_psel;
		o_penable <= 1'b0;
		o_pwrite  <= 1'b1;
		o_paddr   <= s_addr;
		o_pwdata  <= s_wdata;
		o_ack     <= 1'b0;
		o_error   <= 1'b0;
		apb_state <= ST_RQST;
	     end else if (s_wrreq && (&s_wstrb==1'b0)) begin
		o_ack     <= 1'b1;
		o_error   <= 1'b1;
		apb_state <= ST_IDLE;
	     end else begin
		o_psel    <=  'b0;
		o_penable <= 1'b0;
		//o_pwrite  <= 1'b0;
		//o_paddr   <=  'b0;
		//o_pwdata  <=  'b0;
		//o_rdata   <=  'b0;
		o_ack     <= 1'b0;
		o_error   <= 1'b0;
		apb_state <= ST_IDLE;
	     end
	  end
	  ST_RQST : begin
	     o_penable <= 1'b1;
	     apb_state <= ST_WAIT;
	  end
	  ST_WAIT : begin
	     if (pready) begin
		o_psel    <=  'b0;
		o_penable <= 1'b0;
		o_ack     <= 1'b1;
		o_error   <= pslverr;
		if (!o_pwrite) begin
		   o_rdata <= prdata;
		end
		apb_state <= ST_IDLE;
	     end
	  end
	  default : begin
	     o_psel    <=  'b0;
	     o_penable <= 1'b0;
	     o_pwrite  <= 1'b0;
	     o_paddr   <=  'b0;
	     o_pwdata  <=  'b0;
	     o_rdata   <=  'b0;
	     o_ack     <= 1'b0;
	     o_error   <= 1'b0;
	     apb_state <= ST_IDLE;
	  end
	endcase // case (apb_state)
     end

endmodule // apb_if
