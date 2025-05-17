module testbench ();
reg waiting_main, waiting_first;
reg clk,rst;


initial
forever #5 clk = ~clk;

initial
begin
rst = 1'b1;
#100
rst = 1'b0;
waiting_main = 1;
#100
waiting_first=1;
#100
waiting_first=0;
#100
$finish;
end
traffic traffic_dut (.rst (rst), .clk(clk), .waiting_main(waiting_main),.waiting_first(waiting_first));
endmodule
