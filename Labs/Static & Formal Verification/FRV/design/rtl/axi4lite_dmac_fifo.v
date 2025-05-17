module axi4lite_dmac_fifo
  #(parameter DEPTH = 4,
    parameter WIDTH = 32)
   (input logic              CLK,
    input logic 	     RSTN,
    input logic 	     WREN,
    input logic 	     RDEN,
    input logic [WIDTH-1:0]  WDATA,
    output logic [WIDTH-1:0] RDATA,
    output logic 	     EMPTY,
    output logic 	     FULL);

   localparam PTRWD = $clog2(DEPTH);

   logic [WIDTH-1:0] buffer [0:DEPTH-1];
   logic 	     o_empty, o_full;

   logic [PTRWD-1:0] wptr, rptr;
   logic [PTRWD:0]   cnts;

   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) cnts <= 'd0;
      else cnts <= cnts + WREN - RDEN;
   end
   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 wptr <= 'd0;
	 rptr <= 'd0;
      end else begin
	 if (WREN) begin
	    if ((wptr+'d1)==DEPTH) wptr <= 'd0;
	    else wptr <= (wptr + 'd1);
	 end
	 if (RDEN) begin
	    if ((rptr+'d1)==DEPTH) rptr <= 'd0;
	    else rptr <= (rptr + 'd1);
	 end
      end
   end
   always @(posedge CLK or negedge RSTN) begin
      if (!RSTN) begin
	 for (int i=0;i<DEPTH;i++)
	   buffer[i] <= 'b0;
      end else begin
	 if (WREN) buffer[wptr] <= WDATA;
      end
   end

   assign RDATA = buffer[rptr];
   assign EMPTY = (cnts=='d0);
   assign FULL  = (cnts==DEPTH);

endmodule // axi4lite_dmac_fifo
