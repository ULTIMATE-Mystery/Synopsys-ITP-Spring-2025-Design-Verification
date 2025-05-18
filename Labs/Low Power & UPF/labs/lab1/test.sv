program automatic test(router_io.TB rtr_io, reset_io.TB rst_io);
  `ifdef UPF
  import UPF::*;
  `endif
  bit[3:0] sa;
  bit[3:0] da;
  logic[7:0] payload[$];
  int run_for_n_packets;

  initial begin
  `ifdef UPF connect_supplies(); `endif
    reset();

    run_for_n_packets = 21;

    sa = 3;
    run_packets();
    sa = 0;
    fork
    `ifdef UPF power_cycle(); `endif
      run_packets();
    join
    
  end

  task run_packets();
  
  repeat(run_for_n_packets) begin

   gen();
   send();
    
  end
 
  repeat(10) @(rtr_io.drvClk);
  endtask: run_packets

  task reset();
    rst_io.reset_n = 1'b0;
    rtr_io.drvClk.frame_n <= '1;
    rtr_io.drvClk.valid_n <= '1;
    repeat(2) @rst_io.mst;
    rst_io.mst.reset_n <= 1'b1;
    repeat(15) @(rst_io.mst);
  endtask: reset

  task gen();
  
    da = 7;
    payload.delete(); //clear previous data
    repeat($urandom_range(4,2))
      payload.push_back($urandom);
  
  endtask: gen

  task send();
  
    send_addrs();
    send_pad();
    send_payload();

  endtask: send

  task send_addrs();
  
    rtr_io.drvClk.frame_n[sa] <= 1'b0; //start of packet
    for(int i = 0; i<4; i++) begin
      rtr_io.drvClk.din[sa] <= da[i]; //i'th bit of da
      @(rtr_io.drvClk);
    end

  endtask: send_addrs

  task send_pad();
  

    rtr_io.drvClk.frame_n[sa] <= 1'b0;
    rtr_io.drvClk.valid_n[sa] <= 1'b1;
    rtr_io.drvClk.din[sa] <= 1'b1;
    repeat(5) @(rtr_io.drvClk);

  endtask: send_pad
  task send_payload();
  
    foreach(payload[index])
      for(int i=0; i<8; i++) begin
        rtr_io.drvClk.din[sa] <= payload[index][i];
        rtr_io.drvClk.valid_n[sa] <= 1'b0; //driving a valid bit
        rtr_io.drvClk.frame_n[sa] <= ((i == 7) && (index == (payload.size() - 1)));
        @(rtr_io.drvClk);
      end
    rtr_io.drvClk.valid_n[sa] <= 1'b1;
  
  endtask: send_payload

`ifdef UPF
  task power_cycle();
    power_off(50000);
    power_on();
  endtask: power_cycle

  task power_off(time off_time);
    router_test_top.dut.pwr.ipwrcon_iso_n[3] = 1'b0; //isolate
    @rtr_io.drvClk;
    router_test_top.dut.pwr.ipwrcon_pd_n[3] = 1'b1; //turn_off power
    #off_time;
  endtask: power_off

  task power_on();
    router_test_top.dut.pwr.ipwrcon_pd_n[3] = 1'b0; //power on
    @rtr_io.drvClk;
    router_test_top.dut.pwr.ipwrcon_iso_n[3] = 1'b1; //unisolate
    @rtr_io.drvClk;
  endtask: power_on


  task connect_supplies();
    // Task 5 Step 2 Uncomment the two lines that control the power domain switch and isolation
    // Todo

    router_test_top.dut.pwr.ipwrcon_pd_n[3] = 1'b0;
    router_test_top.dut.pwr.ipwrcon_iso_n[3] = 1'b1;

    // Task 7 Step 3 Uncomment the two supply_on lines below
    // Todo

    supply_on ("VDD", 1.08);
    //supply_off("VSS");

    // Task 7 Step 9 Comment the supply_off line above and uncomment the supply_on line below
    // Todo

    supply_on ("VSS", 0.0); 
  endtask: connect_supplies
`endif

endprogram: test