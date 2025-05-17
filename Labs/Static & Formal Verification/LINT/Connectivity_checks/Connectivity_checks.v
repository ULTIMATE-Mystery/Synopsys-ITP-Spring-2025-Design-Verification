module top( Reset, Din, Dout, Clkin, Clkout ) ;
input Reset, Din ,Clkin;
output Dout ,Clkout; // VC-Lint flags here
wire Net_undriven;   // VC-Lint flags here
wire Net_unused;
assign Dout = !Reset ? 0 : (Net_undriven ? 1 : ~Din );
endmodule
