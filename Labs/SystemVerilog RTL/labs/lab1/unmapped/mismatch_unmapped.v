/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : W-2024.09-SP2
// Date      : Sun Jun  1 02:41:49 2025
/////////////////////////////////////////////////////////////


module mismatch ( clk, rst_n, A, B, C, D, dout );
  input clk, rst_n, A, B, C;
  output D, dout;
  wire   N0, N1;

  \**SEQGEN**  dout_reg ( .clear(N0), .preset(1'b0), .next_state(D), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(dout), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  GTECH_OR2 C15 ( .A(N1), .B(C), .Z(D) );
  GTECH_AND2 C16 ( .A(A), .B(B), .Z(N1) );
  GTECH_NOT I_0 ( .A(rst_n), .Z(N0) );
endmodule