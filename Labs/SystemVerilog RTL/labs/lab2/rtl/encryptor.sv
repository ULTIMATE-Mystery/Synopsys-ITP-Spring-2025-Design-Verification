// To simplify compilation, fifo module is included here
`include "fifo.sv"

module encryptor #(WIDTH=8, BUF_SIZE=16) (input logic clk, reset_n, wr_n, rd_n, logic [$clog2(WIDTH)-1:0] key, logic[WIDTH-1:0] din, output logic empty, full, logic[WIDTH-1:0] dout);

fifo_io #(WIDTH)           fifo_if();
fifo    #(WIDTH, BUF_SIZE) my_fifo(.*);

assign fifo_if.din  = Barrel_shift(din, key);
assign fifo_if.wr_n = wr_n;
assign fifo_if.rd_n = rd_n;
assign dout         = fifo_if.dout;
assign empty        = fifo_if.empty;
assign full         = fifo_if.full;
  
// The following uses DesignWare barrel shifter
// During synthesis the code in function is ignored by DC and replaced with a DesignWare barrel shifter
// Please note that the argument names must match DesignWare argument names
// If the argument name is different, one would need to tell DC with a DC directive
// Please read documentation on DesignWare
function automatic logic[WIDTH-1:0] Barrel_shift(logic [WIDTH-1:0] A, logic [$clog2(WIDTH)-1:0] SH);
  // synopsys map_to_operator BSH_UNS_OP
  // synopsys return_port_name Z
  logic [WIDTH-1:0] shifted_msbs;
  {Barrel_shift, shifted_msbs} = {A, A} << SH;
endfunction

endmodule  // encryptor