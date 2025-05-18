program automatic test(router_io.TB rtr_io, reset_io.TB rst_io);
  `ifdef UPF
  import UPF::*;
  `endif
  int TRACE_ON = 0; //set to 1 to trace subroutine calls
  bit[3:0] sa;
  bit[3:0] da;
  logic[7:0] payload[$];
  logic[7:0] pkt2cmp_payload[$];      // actual packet data array
  int run_for_n_packets;
  int iport_off = -1, oport_off = -1;
  int off_iports[$];
  int off_oports[$];

  initial begin
    $timeformat(-9, 1, "ns", 10);
    `ifdef UPF connect_supplies(); `endif
    reset();
    run_for_n_packets = 171;

    fork
    run_packets();
    begin
      int off_port[$];
      #35000ns;
      `ifdef UPF 
      //cycle power on input 0
      ip_power_cycle(0, 50000);
      @(rtr_io.drvClk);
      //cycle power on output 2
      op_power_cycle(2, 40000);
      `endif
    end
    join
      
    #40000;
    fork
    run_packets();
    begin
      int off_oport[$];
      #35000ns;
      `ifdef UPF 
      //cycle power on input 0 and output 2 simultaneously
      fork
      begin
        ip_power_cycle(0, 40000);
      end
      begin
        op_power_cycle(2, 50000);
      end
      join
      `endif
    end
    join

    fork
      //cycle power on input 1 while already off
      ip_power_cycle(1, 4000);
      begin #2000 ip_power_cycle(1, 4000); #2000; end
    join

  end


  task run_packets();
  
  if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
  repeat(run_for_n_packets) begin
    gen();
      
    fork
      send();
      recv();
    join

    check();

  end
  repeat(10) @(rtr_io.drvClk);
  endtask: run_packets

  task reset();
  if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    rst_io.reset_n = 1'b0;
    rtr_io.drvClk.frame_n <= '1;
    rtr_io.drvClk.valid_n <= '1;
    repeat(2) @rst_io.mst;
    rst_io.mst.reset_n <= 1'b1;
    repeat(15) @(rst_io.mst);
  endtask: reset

  task gen();
  
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    randomize(sa) with {!(sa inside off_iports);};
    randomize(da) with {!(da inside off_oports);};
    payload.delete(); //clear previous data
    repeat($urandom_range(4,2))
      payload.push_back($urandom);
  
  endtask: gen

  task send();
  
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    send_addrs();
    send_pad();
    send_payload();

  endtask: send

  task send_addrs();
  
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    rtr_io.drvClk.frame_n[sa] <= 1'b0; //start of packet
    for(int i = 0; i<4; i++) begin
      rtr_io.drvClk.din[sa] <= da[i]; //i'th bit of da
      @(rtr_io.drvClk);
    end

  endtask: send_addrs
  task send_pad();
  
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    rtr_io.drvClk.frame_n[sa] <= 1'b0;
    rtr_io.drvClk.valid_n[sa] <= 1'b1;
    rtr_io.drvClk.din[sa] <= 1'b1;
    repeat(5) @(rtr_io.drvClk);

  endtask: send_pad
  task send_payload();
  
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    foreach(payload[index])
      for(int i=0; i<8; i++) begin
        rtr_io.drvClk.din[sa] <= payload[index][i];
      rtr_io.drvClk.valid_n[sa] <= 1'b0; //driving a valid bit
      rtr_io.drvClk.frame_n[sa] <= ((i == 7) && (index == (payload.size() - 1)));
      @(rtr_io.drvClk);
      end
    rtr_io.drvClk.valid_n[sa] <= 1'b1;
  
  endtask: send_payload

  task recv();

    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    get_payload();
  
  endtask: recv

  task get_payload();

    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    pkt2cmp_payload.delete();

    fork
      begin: wd_timer_fork
      fork: frameo_wd_timer
        //Do not use @(negedge rtr_io.oMonClk.frameo_n[da]);
        //This may cause timing issues because of how the LRM defines it.
        begin
          wait(rtr_io.oMonClk.frameo_n[da] != 0);
          @(rtr_io.oMonClk iff(rtr_io.oMonClk.frameo_n[da] == 0 ));
        end
        begin                              //this is another thread
          repeat(1000) @(rtr_io.oMonClk);
          $display("\n%m\n[ERROR]%t Frame signal Output Port:%0d timed out!\n", $realtime, da);
          $finish;
        end
      join_any: frameo_wd_timer
      disable fork;
      end: wd_timer_fork
    join

    forever begin
      logic[7:0] datum;
      for(int i=0; i<8; i=i)  begin //i=i prevents VCS warning messages
        if(!rtr_io.oMonClk.valido_n[da])
          datum[i++] = rtr_io.oMonClk.dout[da];
        if(rtr_io.oMonClk.frameo_n[da])
          if(i==8) begin //byte alligned
            pkt2cmp_payload.push_back(datum);
            return;      //done with payload
          end
          else begin
            $display("\n%m\n[ERROR]%t Packet payload not byte aligned!\n", $realtime);
            $finish;
          end
        @(rtr_io.oMonClk);
      end
      pkt2cmp_payload.push_back(datum);
    end
  endtask: get_payload

  function bit compare(ref string message);

    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    if(payload.size() != pkt2cmp_payload.size()) begin
      message = "Payload size Mismatch:\n";
      message = { message, $sformatf("payload.size() = %0d, pkt2cmp_payload.size() = %0d\n", payload.size(), pkt2cmp_payload.size()) };
      return (0);
    end
    if(payload == pkt2cmp_payload) ;
    else begin
      message = "Payload Content Mismatch:\n";
      message = { message, $sformatf("Packet Sent:   %p\nPkt Received:   %p", payload, pkt2cmp_payload) };
      return (0);
    end
    message = "Successfully Compared";
    return(1);
  endfunction: compare

  function void check();

    string message;
    static int pkts_checked = 0;

    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    if (!compare(message)) begin
      $display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
      $finish;
    end
    $display("[NOTE]%t Packet #%0d %s", $realtime, pkts_checked++, message);
  endfunction: check

  task ip_power_cycle(int port_no, time off_time);
    static int off_iport[$];
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    `ifdef UPF
    off_iports.push_back(port_no); //save port_no to be turned off
    @(rtr_io.drvClk);
    ip_power_off(port_no, off_time);
    ip_power_on(port_no);
    off_iport = off_iports.find_first_index(port) with (port == port_no);
    if(off_iport.size()) off_iports.delete(off_iport[0]);
    off_iport.delete();
    `endif
  endtask: ip_power_cycle

  task ip_power_off(int port_no, time off_time);  //input port off
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    `ifdef UPF
    //wait for frame_n for port_no to go inactive
    if(rtr_io.iMonClk.frame_n[port_no] !== 1'b1);
      @(rtr_io.drvClk iff(rtr_io.iMonClk.frame_n[port_no] === 1'b1));
      router_test_top.dut.pwr.ipwrcon_iso_n[port_no] = 1'b0; //isolate
      @rtr_io.drvClk;
      router_test_top.dut.pwr.ipwrcon_pd_n[port_no] = 1'b1; //turn_off power
      #off_time;
    `endif
  endtask: ip_power_off

  task ip_power_on(int port_no);
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    `ifdef UPF
      router_test_top.dut.pwr.ipwrcon_pd_n[port_no] = 1'b0; //power on
      @rtr_io.drvClk;
      router_test_top.dut.pwr.ipwrcon_iso_n[port_no] = 1'b1; //unisolate
      @rtr_io.drvClk;
    `endif
  endtask: ip_power_on

  task op_power_cycle(int port_no, time off_time);
    static int off_oport[$];
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    //wait for output port to be idle
    if(rtr_io.oMonClk.frameo_n[port_no] !== 1'b1);
    @(rtr_io.oMonClk iff(rtr_io.oMonClk.frameo_n[port_no] == 1'b1)); 
    off_oports.push_back(port_no);
    @(rtr_io.drvClk);
    op_power_off(port_no, off_time);
    op_power_on(port_no);
    off_oport = off_oports.find_first_index(port) with (port == port_no);
    if(off_oport.size()) off_oports.delete(off_oport[0]);
    off_oport.delete();
  endtask: op_power_cycle
  task op_power_off(int port_no, time off_time);
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    `ifdef UPF
      router_test_top.dut.pwr.opwrcon_save_n[port_no] = 1'b0; //assert save state
      @(rtr_io.drvClk);
      router_test_top.dut.pwr.opwrcon_save_n[port_no] = 1'b1; //deassert save state
      @(rtr_io.drvClk);
      router_test_top.dut.pwr.opwrcon_iso_n[port_no] = 1'b0; //isolate
      @rtr_io.drvClk;
      router_test_top.dut.pwr.opwrcon_pd_n[port_no] = 1'b1; //turn_off power
      #off_time;
    `endif
  endtask: op_power_off

  task op_power_on(int port_no);
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    `ifdef UPF
    router_test_top.dut.pwr.opwrcon_pd_n[port_no] = 1'b0; //turn_on power
      @rtr_io.drvClk;
      router_test_top.dut.pwr.opwrcon_restore_n[port_no] = 1'b0; //assert restore state
      @(rtr_io.drvClk);
      router_test_top.dut.pwr.opwrcon_restore_n[port_no] = 1'b1; //deassert restore state
      @(rtr_io.drvClk);
      router_test_top.dut.pwr.opwrcon_iso_n[port_no] = 1'b1; //unisolate
    `endif
  endtask: op_power_on


  task connect_supplies();
    if (TRACE_ON) $display("[TRACE]%t :%m", $realtime);
    `ifdef UPF
      router_test_top.dut.pwr.ipwrcon_pd_n = '0;
      router_test_top.dut.pwr.ipwrcon_iso_n = '1;
      router_test_top.dut.pwr.opwrcon_pd_n = '0;
      router_test_top.dut.pwr.opwrcon_iso_n = '1;
      router_test_top.dut.pwr.opwrcon_save_n = '1; 
      router_test_top.dut.pwr.opwrcon_restore_n = '1;
      supply_on ("VDD", 1.08);
      supply_on ("VSS", 0.0);
    `endif
  endtask: connect_supplies

endprogram: test