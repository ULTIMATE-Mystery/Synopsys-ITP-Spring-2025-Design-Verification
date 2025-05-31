module traffic_light_test_top;
  logic clk, reset_n;
  logic green_on, yellow_on, red_on;

  traffic_light dut(.*);

  initial begin
    $timeformat(0, 1, "s", 10);
    clk = 0;
  end

  always begin
    #(1s/2) clk = ~clk;
  end

  initial begin
    reset_n = 1;
    repeat (2) @(posedge clk);
    reset_n = 0;
    @(posedge clk);
    reset_n = 1;
    @(posedge clk);
    #200s;
    $finish;
  end
endmodule