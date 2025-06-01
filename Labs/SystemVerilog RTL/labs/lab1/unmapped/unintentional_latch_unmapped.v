/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : W-2024.09-SP2
// Date      : Sun Jun  1 03:10:25 2025
/////////////////////////////////////////////////////////////


module unintentional_latch ( clk, rst_n, A, B, selA, dout );
  input clk, rst_n, A, selA;
  output B, dout;
  wire   N0, N1, N2, N3;

  \**SEQGEN**  dout_reg ( .clear(N3), .preset(1'b0), .next_state(B), 
        .clocked_on(clk), .data_in(1'b0), .enable(1'b0), .Q(dout), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  SELECT_OP C18 ( .DATA1(A), .DATA2(1'b0), .CONTROL1(N0), .CONTROL2(N1), .Z(B)
         );
  GTECH_BUF B_0 ( .A(selA), .Z(N0) );
  GTECH_BUF B_1 ( .A(N2), .Z(N1) );
  GTECH_NOT I_0 ( .A(selA), .Z(N2) );
  GTECH_NOT I_1 ( .A(rst_n), .Z(N3) );
endmodule