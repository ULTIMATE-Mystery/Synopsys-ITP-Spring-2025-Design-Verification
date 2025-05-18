`ifndef RESET_IO__SV
`define RESET_IO__SV

interface reset_io(input logic clk);
  logic        reset_n;

//`ifndef SYNTHESIS
  clocking mst @(posedge clk);
    output reset_n;
  endclocking

  clocking mon @(posedge clk);
    input reset_n;
  endclocking
//`endif

  modport dut(input reset_n);
  modport TB(clocking mst, output reset_n);
endinterface: reset_io
`endif