module router_test_top;
  parameter simulation_cycle = 100 ;
  bit  SystemClock;

  reset_io  reset_if(SystemClock);
  router_io router_if(SystemClock);
  host_io   host_if(SystemClock);
  power_io  power_if();
  router    dut(.clk(SystemClock), .reset_n(reset_if.reset_n), .io(router_if), .host(host_if) `ifdef UPF,.pwr(power_if) `endif);
  test      t(router_if, reset_if);

  initial begin
    $fsdbDumpvars("+power");
    forever #(simulation_cycle/2) SystemClock = ~SystemClock ;
  end
endmodule  