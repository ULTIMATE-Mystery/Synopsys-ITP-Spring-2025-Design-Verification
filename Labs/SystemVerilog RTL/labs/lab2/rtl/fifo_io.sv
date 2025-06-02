// control pins:
// input: reset_n  - active low reset
// input: clk	   - master clock input

// input port pins:
// input: rd_n     - read enable: dout valid when not empty
// input: wr_n     - write enable: din captured at clock edge, available for read at next clock edge
// input: din	   - the data input captured at next clock edge when wr_n is asserted

// output port pins:
// output: empty   - fifo is empty, dout not valid
// output: full	   - fifo is full, din not captured at next clock edge
// output: dout	   - the data output valid when not empty and read_n is asserted

`ifndef SYNTHESIS
interface fifo_io #(WIDTH = 8) (input clk); // The clk is needed only for simulation to emulation external register timing
`else
interface fifo_io #(WIDTH = 8) ();          // clk is not needed for RTL
`endif

  logic             rd_n,
                    wr_n,
                    empty,
                    full;

  logic [WIDTH-1:0] din,
                    dout;

// The following emulates register timing for simulation device driver development.
// If compiled during synthesis, these clocking blocks will be ignored and an warning issued.
// The warning is avoided with the SYNTHESIS directive.
`ifndef SYNTHESIS
  clocking drvWrClk @(posedge clk);
    default input #1ns output #1ns;
    output wr_n;
    output din;
    input  full;
  endclocking

  clocking drvRdClk @(posedge clk);
    default input #1ns output #1ns;
    output rd_n;
    input  empty;
    input  dout;
  endclocking

  clocking monWrClk @(posedge clk);
    default input #1ns output #1ns;
    input  wr_n;
    input  din;
  endclocking

  clocking monRdClk @(posedge clk);
    default input #1ns output #1ns;
    input  rd_n;
    input  dout;
  endclocking
`endif

  // Lab 2 Task 3 Step 2
  //
  // Add a modport called "fifo" with port directions to be used by the fifo module.
  // DO NOT include clock or reset in the modport.
  //
  // Hint:
  // module fifo #(WIDTH=8, BUF_SIZE=16) (input logic clk, reset_n, rd_n, wr_n, logic[WIDTH-1:0] din, output logic empty, full, logic[WIDTH-1:0] dout);
  // modport fifo (input rd_n, ...);
  //
  // ToDo:
	modport fifo (input rd_n, wr_n, din, output empty, full, dout);

endinterface