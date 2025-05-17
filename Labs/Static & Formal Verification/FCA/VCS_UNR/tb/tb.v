module TB ();

reg rst;
reg clk;
reg waiting_main;
reg waiting_first;
reg green_main, yellow_main, red_main, 
       green_first, yellow_first, red_first;
initial clk = 0;

always #10 clk = ~clk;

initial 
begin
	rst = 1;
	#30 rst = 0;
	#40 waiting_main = 1;
	#30 waiting_first = 1;
	#100 $finish ;
end

traffic T1 (.*);

endmodule
