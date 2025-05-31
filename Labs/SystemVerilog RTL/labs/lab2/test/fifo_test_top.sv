`define StringConvert(s) `"s`"

module fifo_test_top;
  parameter WIDTH    = 8;
  parameter BUF_SIZE = 16;

  string           design = `StringConvert(`DESIGN);
  bit              clk     = 0;
  logic            reset_n;

  fifo_io#(WIDTH) fifo_if(clk);

`ifdef GATE
  // Lab 2 Task 9 Step 6
  //
  // Add the remapped gate-level module here:
  //
  // ToDo:


`else
  // Lab 2 Task 5 Step 2
  //
  // Convert the fifo instantiation to the interface.
  //
  // ToDo:
  fifo#(WIDTH, BUF_SIZE) dut(.*,
                             .rd_n  (fifo_if.rd_n),
                             .wr_n  (fifo_if.wr_n),
                             .full  (fifo_if.full),
                             .empty (fifo_if.empty),
                             .din   (fifo_if.din),
                             .dout  (fifo_if.dout));
`endif

  always begin
    #(100/2) clk = ~clk ;
  end

  initial begin
    int errors_found = 0;
    logic [WIDTH-1:0] data, expected[$];
    reset_n = 1;
    repeat(2) @(fifo_if.drvWrClk);
    #($urandom_range(0,100)); // delay some random amount of time from clock edge
    reset_n      = 1'b0;
    fifo_if.rd_n = 1'b1; // must react to reset by deasserting control signal
    fifo_if.wr_n = 1'b1; // must react to reset by deasserting control signal
    repeat(2) @(fifo_if.drvWrClk);
    #1 reset_n = 1; // delay is to avoid metastability issue with release of reset
    @(fifo_if.drvWrClk);

    while (fifo_if.drvWrClk.full === 1'b0) begin
      data = $urandom();
      $display($sformatf("Input data is: %h", data));
      fifo_if.drvWrClk.wr_n <= 1'b0;
      fifo_if.drvWrClk.din  <= data;
      expected.push_back(data);
      @(fifo_if.drvWrClk);
    end
    fifo_if.drvWrClk.wr_n <= 1;
    while (fifo_if.drvRdClk.empty === 1'b0) begin
      fifo_if.drvRdClk.rd_n <= 0;
      @(fifo_if.drvRdClk);
      data = expected.pop_front();
      if (fifo_if.drvRdClk.dout == data) begin
        $display($sformatf("MATCHED: expected is: %h, actual is: %h", data, fifo_if.drvRdClk.dout));
      end else begin
        $error($sformatf("MISMATCH: expected is: %h, actual is: %h", data, fifo_if.drvRdClk.dout));
        errors_found++;
      end
      if (fifo_if.drvRdClk.empty !== 1'b0) begin
        fifo_if.drvRdClk.rd_n <= 1;
        break;
      end
    end
    repeat(2) @(fifo_if.drvWrClk);

    if (errors_found == 0) begin
      `ifndef GATE
        $display($sformatf("\n\nRTL level simulation PASSED! All values matched for %p.\n\n", design));
      `else
        $display($sformatf("\n\nGATE level simulation PASSED! All values matched for %p.\n\n", design));
      `endif
    end else begin
      `ifndef GATE
        $display($sformatf("\n\nRTL level simulation FAILED! %0d errors detected.\n\n", errors_found));
      `else
        $display($sformatf("\n\nGATE level simulation FAILED! %0d errors detected.\n\n", errors_found));
      `endif
    end

    $finish;
  end
endmodule