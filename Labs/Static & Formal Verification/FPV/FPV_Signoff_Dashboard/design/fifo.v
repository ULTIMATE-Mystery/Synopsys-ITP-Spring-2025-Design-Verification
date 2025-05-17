module fifo #(parameter WIDTH = 4,
	      parameter DEPTH = 16,
	      parameter L2D = 4
	      )
	      
   (input clk,
    input resetn,
    input [WIDTH-1:0] data_in,
    input push_req,
    output push_ack,
    input pop_req,
    output pop_ack,
    output [WIDTH-1:0] data_out,
    output full,
    output empty,
    output timeout
    );

   reg 		   full_nxt;
   reg 		   empty_nxt;
      
   reg [WIDTH-1:0] data  [DEPTH-1:0];
   reg [L2D:0] 	   ptr;
   reg [WIDTH-1:0] data_o_nxt;
   wire 	   push_hsk;
   wire 	   pop_hsk;
   reg [2:0]       timer;

   assign 	   push_hsk   = push_req && push_ack;

   assign 	   pop_hsk  = pop_req && pop_ack;
   
   assign          timeout = timer < 3;

   always @(posedge clk or negedge resetn)
     if (!resetn)
       ptr <= {(L2D+1){1'b0}};
     else ptr <= ptr + push_hsk - pop_hsk;
   
   always @(posedge clk)
     if (push_hsk)
       data[0] <= data_in;

   genvar n;

   generate for (n=0;n<DEPTH-1;n++) begin
      always @(posedge clk)
	if (push_hsk)
	  data[n+1] <= data[n];
   end
    endgenerate

   
   always @(posedge clk)
     if (pop_hsk)
       data_o_nxt <= data[ptr-1];

   assign data_out = data_o_nxt;

//   assign full = (ptr == (DEPTH)); // BUG
   assign full = (ptr == (DEPTH-1)); // FIX

   assign empty = (ptr == 0);

   assign push_ack = push_req && !full;

   assign pop_ack = pop_req && !empty;

   always @(posedge clk or negedge resetn)
     if (!resetn)
       timer <= 3'b111;
     else if (push_req)
       timer <= 3'b111;
     else if (timer != 0)
       timer <= timer - 1'b1;

endmodule
