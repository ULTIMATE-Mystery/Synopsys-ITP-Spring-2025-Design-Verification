/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09-SP2
// Date      : Sun Jun  1 03:10:28 2025
/////////////////////////////////////////////////////////////


module unintentional_latch ( clk, rst_n, A, B, selA, dout );
  input clk, rst_n, A, selA;
  output B, dout;


  DFFARX1_HVT dout_reg ( .D(B), .CLK(clk), .RSTB(rst_n), .Q(dout) );
  AND2X1_HVT U4 ( .A1(A), .A2(selA), .Y(B) );
endmodule