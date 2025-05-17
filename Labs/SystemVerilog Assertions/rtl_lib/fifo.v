// control pins:
// input: reset_n	- active low asynchrouns reset
// input: clock		- master clock input
// input: rd_n		- read from fifo (low active)
// input: wr_n		- write to fifo (low active)
// output: empty	- tells output that fifo is empty
// output: full		- tells input that fifo is full
// output: rd_error	- tells output that read is in error
// output: wr_error	- tells input that write is in error

// data pins:
// input: din		- the data input
// output: dout		- the data output
//
// note1: when empty, dout is not valid and rd_n is not accepted.
// note2: when full, wr_n is not accepted.
// note3: simultaneous read and writes are allowed.
// note4: correct usage of fifo is up to user.  violation of full or empty will
//        cause error flags to be set.  User can use error flags for re-try.
// note5: WORD_SIZE parameter defines the number of bits for din and dout.
// note6: COUNTER_SIZE defines 2**COUNTER_SIZE for the fifo size.

module fifo(reset_n, clock, din, dout, rd_n, wr_n, empty, full, rd_error, wr_error);
parameter WORD_SIZE=16;
parameter COUNTER_SIZE=10;
parameter DEPTH=1<<COUNTER_SIZE;
input reset_n, clock, rd_n, wr_n;
input [WORD_SIZE-1:0] din;
output empty, full, rd_error, wr_error;
output [WORD_SIZE-1:0] dout;

reg empty, full;
reg [WORD_SIZE-1:0] reg_array[DEPTH];
reg [COUNTER_SIZE:0] rd_cntr, wr_cntr;
reg ptr_match;

assign dout = reg_array[rd_cntr[COUNTER_SIZE-1:0]];
assign rd_error = empty && !rd_n;
assign wr_error = full && !wr_n;
assign ptr_match = (rd_cntr[COUNTER_SIZE-1:0] == wr_cntr[COUNTER_SIZE-1:0]);
assign empty = (rd_cntr[COUNTER_SIZE]==wr_cntr[COUNTER_SIZE]) && ptr_match;
assign full = !(rd_cntr[COUNTER_SIZE]==wr_cntr[COUNTER_SIZE]) && ptr_match;

/* sv_pragma
property p_wr_err_n;
	disable iff(!reset_n) @(posedge clock) !wr_error ;
endproperty
property p_two_rd_error();
  disable iff(!reset_n) @(posedge clock) (!(rd_error && $stable(rd_error)));
endproperty
*/

//Concurrent assertion does not have to be in a procedural block
//sv_pragma a_wr_err_n: assert property(p_wr_err_n);
//sv_pragma  a_two_rd_err: assert property (p_two_rd_error) else begin $display("[FATAL]%m: two read errors in a row %t", $realtime); $fatal; end

always @(posedge clock or negedge reset_n) begin
  if (!reset_n) begin
    rd_cntr <= 0;
    wr_cntr <= 0;
	
  end else begin
    case ({rd_n, wr_n})
      2'b00: case (1)
               (!rd_error && !wr_error): begin
                 reg_array[wr_cntr[COUNTER_SIZE-1:0]] <= din;
                 wr_cntr <= wr_cntr + 1;
                 rd_cntr <= rd_cntr + 1;
               end
               (!rd_error && wr_error): begin
                 rd_cntr <= rd_cntr + 1;
               end
               (rd_error && !wr_error): begin
                 reg_array[wr_cntr[COUNTER_SIZE-1:0]] <= din;
                 wr_cntr <= wr_cntr + 1;
               end
             endcase
      2'b01: if (!rd_error) rd_cntr <= rd_cntr + 1;
      2'b10: if (!wr_error) begin
               reg_array[wr_cntr[COUNTER_SIZE-1:0]] <= din;
               wr_cntr <= wr_cntr + 1;
             end
    endcase
  end
end
endmodule  //fifo