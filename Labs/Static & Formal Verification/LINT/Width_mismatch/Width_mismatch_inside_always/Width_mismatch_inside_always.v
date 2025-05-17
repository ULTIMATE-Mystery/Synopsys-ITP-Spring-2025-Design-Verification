module top(input clk,
		   input rst,
		   input [2:0]in1,
		   input [5:0]in2,
		   output reg [3:0]dout
		   );

always @(posedge clk)
begin
	dout <= rst ? in1 : in2; //VC Lint flags here
end
endmodule
