`ifndef HOST_IO__SV
`define HOST_IO__SV

interface host_io(input logic clk);
  logic        wr_n, rd_n;
  wire  [15:0] address;
  wire  [15:0] data;

`ifndef SYNTHESIS
  clocking mst @(posedge clk);
    inout   data;
    output  address;
    output  wr_n;
    output  rd_n;
  endclocking

  clocking mon @(posedge clk);
    input  data;
    inout  address;
    input  wr_n;
    input  rd_n;
  endclocking
`endif

  modport dut(input wr_n, rd_n, inout data, address);
endinterface: host_io
`endif