program automatic test(router_io.TB rtr_io);
  `include "Packet.sv"
  int run_for_n_packets;      // number of packets to test
  int TRACE_ON = 0;

  `include "router_test.h"
  `include "Driver.sv"
  `include "Receiver.sv"
  `include "Generator.sv"
  `include "Scoreboard.sv"

  semaphore sem[];
  Driver drvr[];
  Receiver rcvr[];                     // receiver
  Generator gen[];                        // generator
  Scoreboard sb;                         // scoreboard

  initial begin


    run_for_n_packets = 200;
	sem  = new[16];
	drvr = new[16];
	rcvr = new[16];
	gen = new[16];
	sb  = new("Scoreboard");

	foreach (sem[i]) sem[i] = new(1);
	foreach (gen[i]) gen[i] = new($sformatf("gen[%0d]", i), i);
	foreach (drvr[i])
	  drvr[i] = new($sformatf("drvr[%0d]", i), i, sem, gen[i].out_box, sb.driver_mbox,rtr_io);
	foreach (rcvr[i])
	  rcvr[i] = new($sformatf("rcvr[%0d]", i), i, sb.receiver_mbox, rtr_io);

	reset();


	sb.start();
	foreach (gen[i]) gen[i].start();
	foreach (drvr[i]) drvr[i].start();
	foreach (rcvr[i]) rcvr[i].start();


	wait(sb.DONE.triggered);

  end
  
  task reset();
    rtr_io.reset_n = 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
	repeat(2) @rtr_io.cb;
    rtr_io.cb.reset_n <= 1'b1;
    repeat(15) @(rtr_io.cb);
  endtask: reset

endprogram: test