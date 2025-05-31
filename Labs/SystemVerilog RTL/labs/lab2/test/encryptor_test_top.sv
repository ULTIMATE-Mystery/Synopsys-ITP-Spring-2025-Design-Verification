`define StringConvert(s) `"s`"

module encryptor_test_top;
  parameter WIDTH    = 8;
  parameter BUF_SIZE = 16;

  string                    design = `StringConvert(`DESIGN);
  bit                       clk = 0;
  logic                     reset_n;
  logic                     empty;
  logic                     full;
  logic                     wr_n;
  logic                     rd_n;
  logic [WIDTH-1:0]         din;
  logic [WIDTH-1:0]         dout;
  logic [$clog2(WIDTH)-1:0] key;

`ifdef GATE
  // Lab 2 Task 10 Step 6
  //
  // Add the remapped gate-level module here:
  //
  // ToDo:




`else
  encryptor#(WIDTH, BUF_SIZE) dut(.*);
`endif

  always begin
    #(100/2) clk = ~clk ;
  end

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

  initial begin
    int errors_found = 0;
    logic [WIDTH-1:0] data, expected[$];
    reset_n = 1;
    repeat(2) @(drvWrClk);
    #($urandom_range(0,100));  // delay some random amount of time from clock edge
    reset_n      = 1'b0;
    key          = $urandom_range(1,2**$clog2(WIDTH)-1);   // pick a random key
    rd_n = 1'b1;       // must react to reset by deasserting control signal
    wr_n = 1'b1;       // must react to reset by deasserting control signal
    din  = '1;         // must react to reset by deasserting control signal
    repeat(2) @(drvWrClk);
    #1 reset_n = 1;            // delay is to avoid metastability issue with release of reset
    @(drvWrClk);

    while (drvWrClk.full === 1'b0) begin
      data = $urandom();
      $display($sformatf("Original data is: %b, key = %0d", data, key));
      drvWrClk.wr_n <= 1'b0;
      drvWrClk.din  <= data;
      begin
        logic [(2*WIDTH-1):0] encrypted_value;
        encrypted_value = {data, data} << key;
        expected.push_back(encrypted_value[2*WIDTH-1:WIDTH]);
      end
      @(drvWrClk);
    end
    drvWrClk.wr_n <= 1;
    while (drvRdClk.empty === 1'b0) begin
      drvRdClk.rd_n <= 0;
      @(drvRdClk);
      data = expected.pop_front();
      if (drvRdClk.dout == data) begin
        $display($sformatf("MATCHED: expected is: %b, actual is: %b", data, drvRdClk.dout));
      end else begin
        $error($sformatf("MISMATCH: expected is: %b, actual is: %b", data, drvRdClk.dout));
        errors_found++;
      end
      if (drvRdClk.empty !== 1'b0) begin
        drvRdClk.rd_n <= 1;
        break;
      end
    end
    repeat(2) @(drvWrClk);

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