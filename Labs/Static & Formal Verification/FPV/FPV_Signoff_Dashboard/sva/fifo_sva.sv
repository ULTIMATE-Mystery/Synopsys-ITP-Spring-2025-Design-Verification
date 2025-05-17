module fifo_sva  
  #(parameter WIDTH = 8,
    parameter DEPTH = 16,
    parameter L2D = 4
    )
   
   (input clk,
    input resetn,
    input [WIDTH-1:0] data_in,
    input push_req,
    input push_ack,
    input pop_req,
    input pop_ack,
    input [WIDTH-1:0] data_out,
    input full,
    input empty,
    input timeout
    );

   // -- Macro for clocking condition of assertions
   // -- we could also use default clocking when only one clock
`define clk_rst @(posedge clk) disable iff (!resetn)
  

   // ---------------------------------------------------------------------------
   // -- Constraints
   // ---------------------------------------------------------------------------


   // Q1. Complete the assumes described in the labels below
   //
   // In absence of push_ack, data_in and push_req should be held stable  
   am_push_req_stable_when_no_ack:
     assume property (`clk_rst (push_req && !push_ack) |=> push_req);

   am_data_in_stable_when_no_ack:
     assume property (`clk_rst (push_req && !push_ack) |=> $stable(data_in));

   // If pop_req is asserted and pop_ack is low, pop_req should be held stable  
   am_pop_req_stable_when_no_ack:
     assume property (`clk_rst (pop_req && !pop_ack) |=> pop_req);

   // ---------------------------------------------------------------------------
  

   
   // --------------------------------------------------------------------------
   // -- Formal Scoreboard
   // --------------------------------------------------------------------------

   // -- Handshake (hsk) Signals
   wire   push_hsk;
   wire   pop_hsk;

   // Here we can safely use the design outputs
   // push_ack and pop_ack because we have verified their behavior with a property.
   //
   // Also note that the hsk signals are not used in the
   // property that checks the ack signals.
   //
   assign push_hsk = push_req && push_ack;
   assign pop_hsk  = pop_req && pop_ack;
   


   //  Q2. Complete the code for the fullness counter to count the
   //      items of data inside the FIFO.
   
    reg [L2D:0] fullness_counter;
   
   // fullness_counter will track the push and pop signals coming into the fifo.
   // Increment on push and decrement on pop
   //
   always @(posedge clk or negedge resetn)
     if (!resetn)
       fullness_counter <= {(L2D+1){1'b0}};
     else
       fullness_counter <= fullness_counter + push_hsk - pop_hsk;
   
   // -- Wire to assign whether or not we have timed out
   wire timerok;
   assign timerok = fifo.timer > 2;
   

   // --------------------------------------------------------------------------
   

   // --------------------------------------------------------------------------
   // -- Assertions
   // --------------------------------------------------------------------------


   // Q3. Complete the assertions below to check the features described in the label

   // Design cannot ack a push when it's full 
   as_no_push_ack_on_full:
     assert property (`clk_rst full |-> !push_ack);

   // Design cannot ack a pop when it's empty 
   as_no_pop_ack_on_empty:
     assert property (`clk_rst empty |-> !pop_ack);
		      
   // Design asserts full flag only when it is actually full
   // You may write the assertion in your style
   as_full_flag_correct:
     assert property (`clk_rst full == (fullness_counter == DEPTH-1));

   // Design asserts empty flag only when it is actually empty
   as_empty_flag_correct:
     assert property (`clk_rst empty == (fullness_counter == 0));

   // Signal timeout should not be asserted when timreok is high and there is an outstanding transation
   as_no_timeout: assert property (`clk_rst ((fifo.timer > 2) && (fifo.timer <= 7)) == !timeout);	 
   
   // Signal timeout should be asserted when timreok is low
   as_expected_timeout: assert property (`clk_rst (timeout == (fifo.timer <= 2)));	 
   
   
   // --------------------------------------------------------------------------


   // --------------------------------------------------------------------------
   // -- Lab Part b
   // --------------------------------------------------------------------------
		      
`ifdef LAB_PART_B	      
   // Q4. Complete the skeleton code to develop a two pointer FIFO whose output
   //     we can compare against the design FIFO
  
   reg  [WIDTH-1:0] data_model [DEPTH-1:0];
   reg  [L2D-1:0]   wptr_model;
   reg  [L2D-1:0]   rptr_model;
   reg  [WIDTH-1:0] data_out_model_r;
   wire [WIDTH-1:0] data_out_model;


   // Correctly reset the wptr.
   // Model fifo, i.e. data_model, gets written with data input.
   // wptr increments for every write
   always @(posedge clk or negedge resetn)
     if (!resetn)
       wptr_model <= {L2D{1'b0}}; 
     else if (push_hsk)
     begin
	data_model[wptr_model] <= data_in;
	wptr_model             <= wptr_model + 1'b1;
     end
   
   // data_output gets value of model fifo head (rptr) on pop req
   always @(posedge clk or negedge resetn)
     if (!resetn)
       rptr_model <= {L2D{1'b0}};
     else if (pop_hsk)
     begin
       data_out_model_r <= data_model[rptr_model];
       rptr_model       <= rptr_model + 1'b1;
     end

   assign data_out_model = data_out_model_r;
   
   //  Q5.  Finish the data integrity check assertion to compare the outputs of
   //       the design and formal model.
   as_data_integrity_check:
      assert property (`clk_rst pop_hsk |=> (data_out_model == data_out));

`endif //LAB_PART_B

   // --------------------------------------------------------------------------
   // -- Additional Propertiecs to get 100% Formal Core Coverage
   // --------------------------------------------------------------------------

   // Properties to verify timer
   reg [2:0] my_timer;

   always @(posedge clk or negedge resetn)
   if (!resetn || push_req)
     my_timer <= 3'b000;
   else if (!push_req && (my_timer < 7))
     my_timer <= my_timer + 1'b1;
   else
     my_timer <= my_timer;

   // Timer should keep decrementing if another push_req doesn't come for 5 cycles
   as_timer_counter_expected: assert property (`clk_rst  (my_timer == (3'b111 - fifo.timer)));

   //// Properties to verify fifo pointer

   //// Push and pop at the same time, fifo counter remains stable
   //as_fullness_counter_stable: assert property (`clk_rst  (##1 (push_hsk && pop_hsk)) |=> $stable(fullness_counter));

   //// Push and no pop, fifo counter increments
   //as_fullness_counter_incremented: assert property (`clk_rst  ((fullness_counter < 7) && (push_hsk && !pop_hsk)) |=> (fullness_counter == $past(fullness_counter) + 1'b1));

   //// Pop and no push, fifo counter decrements
   //as_fullness_counter_decremented: assert property (`clk_rst  ((fullness_counter > 0) && (pop_hsk && !push_hsk)) |=> (fullness_counter == $past(fullness_counter) - 1'b1));

   //// --------------------------------------------------------------------------
   //// -- Additional Propertiecs to get 0% Non Detected in FTA
   //// --------------------------------------------------------------------------

   // Properties to check data decrement during pop_hsk
   as_data_decrement: assert property (`clk_rst  ((fullness_counter > 0) && (pop_hsk && !push_hsk)) |=> (fifo.data[fifo.ptr] == $past(fifo.data[fifo.ptr-1])));

   // Properties to check data increment during push_hsk
   as_data_increment: assert property (`clk_rst  ((fullness_counter < 7) && (push_hsk && !pop_hsk)) |=> (fifo.data[fifo.ptr] == $past(fifo.data[fifo.ptr-1])));

   // Properties to check data stable
   as_data_stable: assert property (`clk_rst  (!push_hsk && !pop_hsk) |=> $stable(fifo.data[fifo.ptr]));

endmodule // fifo_sva
