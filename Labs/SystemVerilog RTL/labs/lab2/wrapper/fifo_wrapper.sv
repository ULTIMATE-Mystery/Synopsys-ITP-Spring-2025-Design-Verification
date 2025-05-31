`ifndef SYNTHESIS

//
// This is an automatically generated file from 
// dc_shell Version P-2019.03 -- Feb 27, 2019
//

// For simulation only. Do not modify.

module fifo_svsim #(WIDTH=8, BUF_SIZE=16) (input logic clk, reset_n, fifo_io.fifo fifo_if);




      fifo_WIDTH16_BUF_SIZE16_I_fifo_if_fifo_io__16 fifo_WIDTH16_BUF_SIZE16_I_fifo_if_fifo_io__16( 
        {>>{ clk }}, {>>{ reset_n }}, {>>{ fifo_if.rd_n }}, 
        {>>{ fifo_if.wr_n }}, {>>{ fifo_if.empty }}, {>>{ fifo_if.full }}, 
        {>>{ fifo_if.din }}, {>>{ fifo_if.dout }} );
endmodule
`endif