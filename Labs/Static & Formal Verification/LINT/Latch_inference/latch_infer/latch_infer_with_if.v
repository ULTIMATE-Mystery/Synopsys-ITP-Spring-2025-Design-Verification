module top(input en,in,
	   output reg out);

always @(en)
  begin
    if(en)
      out <= in;  // VC Lint flags here
  end
endmodule
