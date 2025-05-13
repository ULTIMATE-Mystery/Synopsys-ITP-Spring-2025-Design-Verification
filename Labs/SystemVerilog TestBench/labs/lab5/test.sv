program automatic test(router_io.TB rtr_io);
  `include "Packet.sv"
  int run_for_n_packets;      // number of packets to test
  //Lab 5 - Task 10, Step 2
  //
  //Delete all global variables EXCEPT run_for_n_packets

  //ToDo
  // bit[3:0]   sa;                      // source address
  // bit[3:0]   da;                      // destination address
  // logic[7:0] payload[$];              // expected packet data array
  // logic[7:0] pkt2cmp_payload[$];      // actual packet data array
  // Packet pkt2send = new();
  // Packet pkt2cmp  = new();

  //Lab 5 - Task 10, Step 3
  //
  //Create an int TRACE_ON and initialize to 0 - set to 1 for debugging

  //ToDo
	int TRACE_ON = 0; 					// subroutine tracing control
  //Lab 5 - Task 10, Step 4
  //
  //Add include statements for all header and new class files
  //(router_test.h, Driver.sv, Receiver.sv, Generator.sv, Scoreboard.sv)

  //ToDo
	`include "router_test.h"
	`include "Driver.sv"
	`include "Receiver.sv"
	`include "Generator.sv"
	`include "Scoreboard.sv"
  //Lab 5 - Task 10, Step 5
  //
  //Add the following global variables
  //semaphore sem[];                    // prevent output port collision
  //Driver drvr[];                      // driver objects
  //Receiver rcvr[];                    // receiver objects
  //Generator gen[];                    // generator objects
  //Scoreboard sb;                      // scoreboard object

  //ToDo
	semaphore sem[];                    // prevent output port collision
  Driver drvr[];                      // driver objects
  Receiver rcvr[];                    // receiver objects
  Generator gen[];                    // generator objects
  Scoreboard sb;                      // scoreboard object

  initial begin
		$vcdpluson;
    run_for_n_packets = 2000;

    //Lab 5 - Task 10, Step 6
    //
    //Delete all content of initial block EXCEPT
    //run_for_n_packets = 2000;

    //ToDo
    /*
    reset();
    repeat(run_for_n_packets) begin

      gen();
      
      fork
        send();
        recv();
      join

      check();
    
    end
    repeat(10) @(rtr_io.cb);
		*/
    //Lab 5 - Task 10, Step 7
    //
    //Construct all components
    //Make sure the mailboxes are connected correctly:
    //Each Generators to corresponding Driver (gen[i].out_box);
    //all Drivers to one Scoreboard mailbox (sb.driver_mbox);
    //all Receivers to one Scoreboard mailbox (sb.receiver_mbox)

    //ToDo
		sem = new[16];
		drvr = new[16];
		rcvr = new[16];
		gen = new[16];
		sb = new("sb");
		foreach (sem[i]) sem[i] = new(1);
		foreach (gen[i]) gen[i] = new($sformatf("gen[%0d]", i), i);
		foreach (drvr[i])
			drvr[i] = new($sformatf("drvr[%0d]", i), i, sem, gen[i].out_box, sb.driver_mbox, rtr_io);
		foreach (rcvr[i])
			rcvr[i] = new($sformatf("rcvr[%0d]", i), i, sb.receiver_mbox, rtr_io);
    //Lab 5 - Task 10, Step 8
    //
    //Call reset() to reset the DUT

    //ToDo
		reset();
    //Lab 5 - Task 10, Step 9
    //
    //Start all transactors (gen, sb, drivers and receivers)

    //ToDo
		sb.start();
		foreach(gen[i]) gen[i].start();
		foreach(drvr[i]) drvr[i].start();
		foreach(rcvr[i]) rcvr[i].start();
    //Lab 5 - Task 10, Step 10
    //
    //Wait for the DONE event flag in sb to be triggered

    //ToDo
		wait(sb.DONE.triggered);
  end
  
  task reset();
		if (TRACE_ON) $display("[TRACE]%t %m", $realtime);
    rtr_io.reset_n = 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
    repeat(2) @rtr_io.cb;
    rtr_io.cb.reset_n <= 1'b1;
    repeat(15) @(rtr_io.cb);
  endtask: reset

  //Lab 5 - Task 11, Step 1
  //
  //The following subroutines should be deleted from test.sv.
  // gen()
  // send()
  // send_addr()
  // send_pad()
  // send_payload()
  // recv()
  // get_payload()
  // check()
  //(Make sure reset() is NOT deleted)
  //ToDo

	/*
  task gen();

    static int pkts_generated = 0;
    pkt2send.name = $sformatf("Packet[%0d]", pkts_generated++);
    if(!pkt2send.randomize()) begin
      $display("\n%m\n [ERROR] %t: Randomize Error!!", $realtime);
      $finish;
    end

    sa = pkt2send.sa;
    da = pkt2send.da;
    payload = pkt2send.payload;

  endtask: gen

  task send();

    send_addrs();
    send_pad();
    send_payload();

  endtask: send

  task send_addrs();

    rtr_io.cb.frame_n[sa] <= 1'b0; //start of packet
    for(int i=0; i<4; i++) begin
      rtr_io.cb.din[sa] <= da[i]; //i'th bit of da
      @(rtr_io.cb);
    end

  endtask: send_addrs

  task send_pad();

    rtr_io.cb.frame_n[sa] <= 1'b0;
    rtr_io.cb.din[sa] <= 1'b1;
    rtr_io.cb.valid_n[sa] <= 1'b1;
    repeat(5) @(rtr_io.cb);

  endtask: send_pad

  task send_payload();

    foreach(payload[index])
      for(int i=0; i<8; i++) begin
        rtr_io.cb.din[sa] <= payload[index][i];
        rtr_io.cb.valid_n[sa] <= 1'b0; //driving a valid bit
        rtr_io.cb.frame_n[sa] <= ((i == 7) && (index == (payload.size() - 1)));
        @(rtr_io.cb);
      end
    rtr_io.cb.valid_n[sa] <= 1'b1;
  endtask: send_payload

  task recv();

    static int pkt_cnt = 0;
    get_payload();
    pkt2cmp.da = da;
    pkt2cmp.payload = pkt2cmp_payload;
    pkt2cmp.name = $sformatf("rcvdPkt[%0d]", pkt_cnt++);

  endtask: recv

  task get_payload();

    pkt2cmp_payload.delete();

    fork
    begin: wd_timer_fork
      fork: frameo_wd_timer
      begin
        wait(rtr_io.cb.frameo_n[da] != 0);
        @(rtr_io.cb iff(rtr_io.cb.frameo_n[da] == 0 ));
      end
      begin                              //this is another thread
        repeat(1000) @(rtr_io.cb);
        $display("\n%m\n[ERROR]%t Frame signal timed out!\n", $realtime);
        $finish;
      end
      join_any: frameo_wd_timer
      disable fork;
    end: wd_timer_fork
    join

    forever begin
      logic[7:0] datum;
      for(int i=0; i<8; i=i)  begin //i=i prevents VCS warning messages
        if(!rtr_io.cb.valido_n[da])
          datum[i++] = rtr_io.cb.dout[da];
        if(rtr_io.cb.frameo_n[da])
          if(i==8) begin //byte alligned
            pkt2cmp_payload.push_back(datum);
            return;      //done with payload
          end

          else begin
            $display("\n%m\n[ERROR]%t Packet payload not byte aligned!\n", $realtime);
            $finish;
          end
        @(rtr_io.cb);
      end
      pkt2cmp_payload.push_back(datum);
    end
  endtask: get_payload

  function void check();

    string message;
    static int pkts_checked = 0;

    if (!pkt2send.compare(pkt2cmp, message)) begin
      $display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
      pkt2send.display("ERROR");
      pkt2cmp.display("ERROR");
      $finish;
    end
    $display("[NOTE]%t Packet #%0d %s", $realtime, pkts_checked++, message);
  endfunction: check
	*/

endprogram: test