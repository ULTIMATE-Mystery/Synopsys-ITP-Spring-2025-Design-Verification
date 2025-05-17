//testbench for fifo
`timescale 1ns/1ns

module test;

  parameter FIFO_DEPTH = 8;
  parameter DATA_WIDTH = 8; 

  reg                   Clock;
  reg                   Reset_;
  reg                   WriteEn;
  reg                   ReadEn;
  reg  [DATA_WIDTH-1:0] DataIn;
  wire [DATA_WIDTH-1:0] DataOut;
  wire                  FifoEmpty;
  wire                  FifoHalfFull;
  wire                  FifoFull;
  wire                  Error;

//`begin_faultfree
  FIFO #(.FIFO_DEPTH(FIFO_DEPTH), .DATA_WIDTH(DATA_WIDTH)) DUT 
  (
    .Reset_(Reset_),
    .ReadClk(Clock),
    .WriteClk(Clock),
    .WriteEn(WriteEn),
    .DataIn(DataIn),
    .ReadEn(ReadEn),
    .DataOut(DataOut),
    .Empty_(FifoEmpty),
    .HalfFull_(FifoHalfFull),
    .Full_(FifoFull),
    .Error(Error)
  ); 
//`end_faultfree

/*
  initial
    begin
      Clock = 1'b0;
      forever
        #50 Clock = ~Clock;
   end

  task FifoTransfer;
    input                  Write;
    input [DATA_WIDTH-1:0] WData;
    input                  Read;
    input [DATA_WIDTH-1:0] ExpectedData;
    begin
      if (Write)
        $display("Write %h", WData);
      WriteEn <= Write;
      ReadEn  <= Read;
      DataIn  <= WData;
      @(negedge Clock);
      if (Read === 1'b1)
        begin
          if (DataOut !== ExpectedData)
            begin
              $display($time,": FAIL: got %h, was expecting %h\n", DataOut, ExpectedData);
              //$finish;
            end
          $display("Read %h", DataOut);
        end
      #10; 
      WriteEn <= 1'b0;
      ReadEn  <= 1'b0;
    end
   endtask

  task CheckFlags;
    input Empty;
    input HalfFull;
    input Full;
    begin
      if (FifoEmpty !== Empty)
        begin
          $display($time,": FAIL: wrong 'Empty' flag value, got %h, was expecting %h\n", FifoEmpty, Empty);
          //$finish;
        end
      if (FifoHalfFull !== HalfFull)
        begin
          $display($time,": FAIL: wrong 'HalfFull' flag value, got %h, was expecting %h\n", FifoHalfFull, HalfFull);
          //$finish;
        end
      if (FifoFull !== Full)
        begin
          $display($time,": FAIL: wrong 'Full' flag value, got %h, was expecting %h\n", FifoFull, Full);
          //$finish;
        end
      $display("Check Flags - PASS");
    end
  endtask

  integer i;

  initial
    begin
      // Initialize Memory
      for (int i=0; i < FIFO_DEPTH; i++)
      begin
         #1 test.DUT.sdpram_i1.sdpram_i1.mem_array[i] <= {DATA_WIDTH {0}};
      end
      
      if($test$plusargs("test1"))
      begin
        $display("Using test1");
        `include "./test1.v"
      end
      if($test$plusargs("test2"))
      begin
          $display("Using test2");
         `include "./test2.v"
      end
      if($test$plusargs("test3"))
      begin
          $display("Using test3");
         `include "./test3.v"
      end
       $display("Calling finish");
      #10 $finish;
    end

initial begin
  $fsdbDumpvars;
end

initial 
  begin  
    $dumpports(test.DUT,"fifo.evcd");
  end
*/
endmodule
