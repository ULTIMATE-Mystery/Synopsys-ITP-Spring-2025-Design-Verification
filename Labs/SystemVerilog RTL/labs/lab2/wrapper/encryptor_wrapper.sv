`ifndef SYNTHESIS

//
// This is an automatically generated file from 
// dc_shell Version P-2019.03 -- Feb 27, 2019
//

// For simulation only. Do not modify.

module encryptor_svsim #(WIDTH=8, BUF_SIZE=16) (input logic clk, reset_n, wr_n, rd_n, logic [$clog2(WIDTH)-1:0] key, logic[WIDTH-1:0] din, output logic empty, full, logic[WIDTH-1:0] dout);



  encryptor_WIDTH16_BUF_SIZE16 encryptor_WIDTH16_BUF_SIZE16( {>>{ clk }}, 
        {>>{ reset_n }}, {>>{ wr_n }}, {>>{ rd_n }}, {>>{ key }}, {>>{ din }}, 
        {>>{ empty }}, {>>{ full }}, {>>{ dout }} );
endmodule
`endif