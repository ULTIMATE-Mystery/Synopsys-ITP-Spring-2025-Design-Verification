/*
  control pins:
  input: reset_n   - active low reset
  input: clk	   - master clock input

  input port pins:
  input: fifo_if.rd_n      - read enable: dout valid when not empty
  input: wr_n      - write enable: din captured at clock edge, available for read at next clock edge
  input: din	   - the data input captured at next clock edge when wr_n is asserted

  output port pins:
  output: empty    - fifo is empty, dout not valid
  output: full	   - fifo is full, din not captured at next clock edge
  output: dout	   - the data output valid when not empty and read_n is asserted
*/


// Lab 2 Task 4 Step 2
//
// Convert the module port list to use the fifo_io interface and modport.
//
// ToDo:
module fifo #(WIDTH=8, BUF_SIZE=16) (input logic clk, reset_n, rd_n, wr_n, logic[WIDTH-1:0] din, output logic empty, full, logic[WIDTH-1:0] dout);

logic [WIDTH-1:0]            reg_buffer [BUF_SIZE];
logic [$clog2(BUF_SIZE):0]   count;
logic [$clog2(BUF_SIZE)-1:0] wr_address,
                             rd_address;

// Lab 2 Task 4 Step 3
//
// Convert rd_n, wr_n, din, dout, emput and full to use the interface handle.
//
// For example:
//   assign dout    = reg_buffer[rd_address];
//
// Becomes: 
//   assign fifo_if.dout    = reg_buffer[rd_address];
//
// In gvim, it would be something like the following
//   :50,$s/rd_n/fifo_if.rd_n/g
//   :50,$s/wr_n/fifo_if.wr_n/g
//   :50,$s/din/fifo_if.din/g
//   :50,$s/dout/fifo_if.dout/g
//   :50,$s/empty/fifo_if.empty/g
//   :50,$s/full/fifo_if.full/g
//
// ToDo:

assign dout    = reg_buffer[rd_address];
assign empty   = ((count == 0) && wr_n)        || ((count == 1)          && wr_n && !rd_n);
assign full    = ((count == BUF_SIZE) && rd_n) || ((count == BUF_SIZE-1) && !wr_n && rd_n);

always_ff @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    wr_address <= 0;
    rd_address <= 0;
    count <= 0;
  end else begin
    case ({wr_n, rd_n})
      2'b00: begin 
               reg_buffer[wr_address] <= din;
               wr_address <= wr_address + 1;
               rd_address <= rd_address + 1;
             end
      2'b01: begin
               reg_buffer[wr_address] <= din;
               wr_address <= wr_address + 1;
               count <= count + 1;
             end
      2'b10: begin
               rd_address <= rd_address + 1;
               count <= count - 1;
             end
      2'b11: ;
    endcase
  end
end

endmodule  // fifo