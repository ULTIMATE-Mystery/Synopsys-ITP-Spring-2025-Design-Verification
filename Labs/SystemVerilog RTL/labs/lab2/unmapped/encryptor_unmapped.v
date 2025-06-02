/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : W-2024.09-SP2
// Date      : Sun Jun  1 15:34:02 2025
/////////////////////////////////////////////////////////////


module encryptor_WIDTH16_BUF_SIZE16 ( clk, reset_n, wr_n, rd_n, key, din, 
        empty, full, dout );
  input [3:0] key;
  input [15:0] din;
  output [15:0] dout;
  input clk, reset_n, wr_n, rd_n;
  output empty, full;

  wire   [15:0] \fifo_if.din ;

  fifo_WIDTH16_BUF_SIZE16_I_fifo_if_fifo_io__16 my_fifo ( .clk(clk), .reset_n(
        reset_n), .\fifo_if.rd_n (rd_n), .\fifo_if.wr_n (wr_n), 
        .\fifo_if.empty (empty), .\fifo_if.full (full), .\fifo_if.din (
        \fifo_if.din ), .\fifo_if.dout (dout) );
  BSH_UNS_OP rol_9 ( .A(din), .SH(key), .Z(\fifo_if.din ) );
endmodule