module mismatch_test_top;
  parameter simulation_cycle = 100 ;

  logic  A, B, C, D, dout;
  logic  clk, rst_n;

  mismatch dut(.clk(clk), .rst_n(rst_n), .A(A), .B(B), .C(C), .D(D), .dout(dout));

  initial begin
    $timeformat(-9, 1, "ns", 10);
    clk = 0;
    $monitor(A, B, C, D);
  end

  always begin
    #(simulation_cycle/2) clk = ~clk;
  end

// This test is very painful to write and maintain, but it is what we live with in Verilog.
  initial begin
    rst_n = 1;
    @(posedge clk);
    rst_n = 0;
    A = 0;
    B = 0;
    C = 0;
    @(posedge clk);
    #1;
    rst_n = 1;
    C = 1;
    @(posedge clk);
    #1;
    C = 0;
    @(posedge clk);
    #1;
    C = 1;
    @(posedge clk);
    #1;
    C = 0;
    @(posedge clk);
    $finish;
  end
endmodule