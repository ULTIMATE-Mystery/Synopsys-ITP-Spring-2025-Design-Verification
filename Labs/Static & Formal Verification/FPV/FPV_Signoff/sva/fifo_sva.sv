module fifo_sva
   (input clk,
    input 	 resetn,
    input [7:0]  data_in,
    input 	 push,
    input 	 stall, 
    input 	 pop,
    input [7:0] data_out,
    input 	 full,
    input 	 empty
     );


`define clk_rst @(posedge clk) disable iff (!resetn)

   reg 		   full_nxt;
   reg             empty_nxt;
   reg [1:0] 	   wptr;
   reg [1:0] 	   rptr;
   reg [7:0] 	   data [3:0];
   reg [7:0] 	   data_out_nxt;
   reg [1:0] 	   cntr;
   reg 		   first_push;
   reg 		   first_pop;

 

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
     if (pop  && !stall)
       data_out_nxt <= data[rptr];


  always @(posedge clk or negedge resetn)
     if (!resetn)
       first_push <= 1'b0;
     else if (push && !stall)
       first_push <= 1'b1;
      

   always @(posedge clk or negedge resetn)
     if (!resetn)
       first_pop <= 1'b0;
     else if (pop && first_push && !stall)
       first_pop <= 1'b1;
   
`ifdef step1
   as_data_eq:  assert property (`clk_rst $rose(first_pop) |-> data_out_nxt ==  data_out);
   am_no_stall: assume property (`clk_rst !stall);
   am_no_pop_first_empty: assume property (`clk_rst !first_push |-> !pop);
`endif

`ifdef step2
   as_data_eq:  assert property (`clk_rst $rose(first_pop) |-> data_out_nxt ==  data_out);
   am_no_stall: assume property (`clk_rst !stall);
   am_no_pop_first_empty: assume property (`clk_rst !first_push |-> !pop);
   as_not_empty_and_full: assert property (`clk_rst !(empty && full));

`endif

`ifdef step3
   as_data_eq:  assert property (`clk_rst $rose(first_pop) |-> data_out_nxt ==  data_out);
   am_no_pop_first_empty: assume property (`clk_rst !first_push |-> !pop);
   as_not_empty_and_full: assert property (`clk_rst !(empty && full));
`endif


`ifdef step4
   as_data_eq:  assert property (`clk_rst $rose(first_pop) |-> data_out_nxt ==  data_out);
   am_no_pop_first_empty: assume property (`clk_rst !first_push |-> !pop);
   as_not_empty_and_full: assert property (`clk_rst !(empty && full));
   always @(posedge clk or negedge resetn)
     if (!resetn)
       cntr <= '0;
     else cntr <= cntr + (push && !stall && !full) - (pop && !stall && !empty);

   as_empty_correct: assert property (`clk_rst cntr == 0 |-> empty);
`endif

`ifdef step5
   as_data_eq_first:  assert property (`clk_rst $rose(first_pop) |-> data_out_nxt ==  data_out);
   as_data_eq:  assert property (`clk_rst pop && !stall |=>  data_out_nxt ==  data_out);
   as_data_eq_stall: assert property (`clk_rst stall |=> $stable(data_out));
   am_no_push_on_full: assume property (`clk_rst full |-> !push);
   am_no_pop_on_empty: assume property (`clk_rst empty |-> !pop);
   as_not_empty_and_full: assert property (`clk_rst !(empty && full));
   always @(posedge clk or negedge resetn)
     if (!resetn)
       cntr <= '0;
     else cntr <= cntr + (push && !stall && !full) - (pop && !stall && !empty);

   as_empty_correct: assert property (`clk_rst cntr == 0 == empty);
   as_full_correct: assert property (`clk_rst cntr == 3 == full);
`endif

   
   
   

endmodule
