/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09-SP2
// Date      : Sun Jun  1 02:41:52 2025
/////////////////////////////////////////////////////////////


module mismatch ( clk, rst_n, A, B, C, D, dout );
  input clk, rst_n, A, B, C;
  output D, dout;


  DFFARX1_HVT dout_reg ( .D(D), .CLK(clk), .RSTB(rst_n), .Q(dout) );
  AO21X1_HVT U4 ( .A1(B), .A2(A), .A3(C), .Y(D) );
endmodule