module unintentional_latch_test_top;
  parameter simulation_cycle = 100 ;

  logic  A, B, selA, dout;
  logic  clk, rst_n;

  unintentional_latch dut(.*);

  initial begin
    $timeformat(-9, 1, "ns", 10);
    clk = 0;
    $monitor(A, B, selA);
  end

  always begin
    #(simulation_cycle/2) clk = ~clk;
  end

// This test is very painful to write and maintain, but it is what we live with in Verilog.
  initial begin
    rst_n = 1;
    A = 1;
    selA = 0;
    @(posedge clk);
    rst_n = 0;
    @(posedge clk);
    #1;
    rst_n = 1;
    selA = 1;
    #25;
    A = 0;
    #50;
    A = 1;
    @(posedge clk);
    #1;
    selA = 0;
    #25;
    A = 0;
    #50;
    A = 1;
    @(posedge clk);
    #1;
    selA = 1;
    #25;
    A = 0;
    #50;
    A = 1;
    @(posedge clk);
    #1;
    selA = 0;
    #25;
    A = 0;
    #50;
    A = 1;
    @(posedge clk);
    $finish;
  end
endmodule