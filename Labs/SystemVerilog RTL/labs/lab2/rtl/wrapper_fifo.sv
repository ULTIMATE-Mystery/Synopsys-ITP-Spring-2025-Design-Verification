module wrapper_fifo #(WIDTH = 8, BUF_SIZE = 16) (input clk, reset_n);
	fifo_io #(WIDTH)					 fifo_if();
	fifo		#(WIDTH, BUF_SIZE) fifo_inst (.*);
endmodule