module top(input clk,rst,
		   output reg [3:0]out
		   );

integer i;


always@(posedge clk) 
begin
  i = 1;
  forever   // VC Lint flags here
  begin
    out <= out + i;
  end
end
endmodule
