module router_test_top;
  parameter period = 100 ;
  bit  SystemClock = 0;

  reset_io  reset_if(SystemClock);
  router_io router_if(SystemClock);
  host_io   host_if(SystemClock);
  `ifdef UPF power_io  power_if(); `endif
  router    dut(.clk(SystemClock), .reset_n(reset_if.reset_n), .io(router_if), .host(host_if)
                `ifdef UPF, .pwr(power_if) `endif );
  test      t(router_if, reset_if);

  initial begin
    `ifdef UPF $fsdbDumpvars("+power"); `endif
  end

  always begin
    #(period/2) SystemClock = 1'b1;
    #(period/2) SystemClock = 1'b0;
  end

endmodule