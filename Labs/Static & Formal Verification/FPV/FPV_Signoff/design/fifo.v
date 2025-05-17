module fifo 
   (input clk,
    input        resetn,
    input [7:0]  data_in,
    input        push,
    input        stall, 
    input        pop,
    output [7:0] data_out,
    output       full,
    output       empty
     );

   reg             full_nxt;
   reg             empty_nxt;
   reg [1:0]       wptr;
   reg [1:0]       rptr;
   reg [7:0]       data [3:0];
   reg [7:0]       data_out_nxt;
   reg [1:0]       cntr;
   
   

`ifdef step1
 `define first_rtl
`elsif step2
 `define first_rtl
`endif
`ifdef step3
 `define second_rtl
`elsif step4
 `define second_rtl
`endif
   
   
   
`ifdef first_rtl
 always @(posedge clk or negedge resetn)
     if (!resetn)
       wptr <= '0;
     else if (push)
       wptr <= wptr + 1'b1;
     else if (stall)
       wptr <= wptr;

   always @(posedge clk or negedge resetn)
     if (!resetn)
       rptr <= '0;
     else if (pop)
       rptr <= rptr + 1'b1;
     else if (stall)
       rptr <= rptr;

   always @(posedge clk)
     if (push)
       data[wptr] <= data_in;

   always @(posedge clk)
     if (pop)
       data_out_nxt <= data[rptr];

   always @(posedge clk or negedge resetn)
     if (!resetn)
       cntr <= '0;
     else cntr <= cntr + (push && !stall && !full) - (pop && !stall && !empty);

`endif


`ifdef second_rtl

   always @(posedge clk or negedge resetn)
     if (!resetn)
       wptr <= '0;
     else if (push && !stall)
       wptr <= wptr + 1'b1;
     else if (stall)
       wptr <= wptr;

   always @(posedge clk or negedge resetn)
     if (!resetn)
       rptr <= '0;
     else if (pop && !stall)
       rptr <= rptr + 1'b1;
     else if (stall)
       rptr <= rptr;

   always @(posedge clk)
     if (push && !stall)
       data[wptr] <= data_in;

   always @(posedge clk)
     if (pop && !stall)
       data_out_nxt <= data[rptr];   

   always @(posedge clk or negedge resetn)
     if (!resetn)
       cntr <= '0;
     else cntr <= cntr + (push && !stall && !full) - (pop && !stall && !empty);     
`endif //  `ifdef second_rtl

`ifdef step5
always @(posedge clk or negedge resetn)
     if (!resetn)
       wptr <= '0;
     else if (push && !stall)
       wptr <= wptr + 1'b1;


   always @(posedge clk or negedge resetn)
     if (!resetn)
       rptr <= '0;
     else if (pop && !stall)
       rptr <= rptr + 1'b1;

   always @(posedge clk)
     if (push && !stall)
       data[wptr] <= data_in;

   always @(posedge clk)
     if (pop && !stall)
       data_out_nxt <= data[rptr];   

   always @(posedge clk or negedge resetn)
     if (!resetn)
       cntr <= '0;
     else cntr <= cntr + (push && !stall && !full) - (pop && !stall && !empty);     
`endif   

   assign data_out = data_out_nxt;
   assign full = cntr == 3;
   assign empty = cntr == 0;   
   

   
endmodule
