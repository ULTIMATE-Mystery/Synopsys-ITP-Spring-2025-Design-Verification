module wrapper_encryptor #(WIDTH=8, BUF_SIZE=16) (input logic clk, reset_n, wr_n, rd_n, logic [$clog2(WIDTH)-1:0] key, logic[WIDTH-1:0] din, output logic empty, full, logic[WIDTH-1:0] dout);
  encryptor #(WIDTH, BUF_SIZE) encryptor_inst (.*);
endmodule