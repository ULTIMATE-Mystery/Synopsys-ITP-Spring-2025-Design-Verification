program automatic test(router_io.TB rtr_io);
//Lab 6 - Task 8, Step 2
//
//Delete the variable declarations and the include directives
//ToDo
	/*
  int run_for_n_packets;
  int TRACE_ON = 0;      // subroutine tracing control

  `include "router_test.h"
  `include "Packet.sv"
  `include "Driver.sv"
  `include "Receiver.sv"
  `include "Generator.sv"
  `include "Scoreboard.sv"
	*/

  //Lab 6 - Task 8, Step 3
  //
  //import the complete router_test_pkg
  //ToDo
	import router_test_pkg::*;

  //Lab 6 - Task 11, Step 2
  //
  //Delete the component declarations
  //ToDo
	/*
  semaphore  sem[];    // prevent output port collision
  Driver     drvr[];    // driver objects
  Receiver   rcvr[];    // receiver objects
  Generator  gen[];    // generator objects
  Scoreboard sb;    // scoreboard object
	*/
  //Lab 6 - Task 11, Step 3
  //
  //declare an instance of the Environment. Call it env
  //ToDo
	Environment env;
  initial begin
  //Lab 6 - Task 11, Step 4
  //
  //Delete the initial block test code starting here
  //ToDo
	/*
    run_for_n_packets = 2000;
    sem = new[16];
    gen = new[16];
    drvr = new[16];
    rcvr = new[16];
    sb = new();
    foreach (sem[i])
      sem[i] = new(1);
    foreach (gen[i])
      gen[i] = new($sformatf("gen[%0d]", i), i);
    foreach (drvr[i])
      drvr[i] = new($sformatf("drvr[%0d]", i), i, sem, gen[i].out_box, sb.driver_mbox, rtr_io);
    foreach (rcvr[i])
      rcvr[i] = new($sformatf("rcvr[%0d]", i), i, sb.receiver_mbox, rtr_io);
    reset();
    sb.start();
    foreach(gen[i])
      gen[i].start();
    foreach(drvr[i])
      drvr[i].start();
    foreach(rcvr[i])
      rcvr[i].start();
    wait(sb.DONE.triggered);
  //Delete till here
	*/

  //Lab6 - Task 11, Step 5
  //
  //construct the Environment. Pass a name string and instance of interface
  //ToDo
		env = new("env", rtr_io);
  //Lab6 - Task 11, Step 6
  //
  //Configure the environment using it's configure() method
  //ToDo
		env.configure();
  //Lab6 - Task 11, Step 7
  //
  //Copy the Environment's run_for_n_packets to test's run_for_n_packets
  //This is needed by the Generator and Scoreboard
  //ToDo
		run_for_n_packets = env.run_for_n_packets;
  //Lab6 - Task 11, Step 8
  //
  //Run the test using the run method in the environment
  //ToDo
  	env.run();
  end

  //Lab 6 - Task 11, Step 9
  //
  //Delete the reset task
  //ToDo
	/*
  task reset();
    if (TRACE_ON) $display("[TRACE]%t %m", $realtime);
    rtr_io.reset_n = 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
    repeat(2) @rtr_io.cb;
    rtr_io.cb.reset_n <= 1'b1;
    repeat(15) @(rtr_io.cb);
  endtask: reset
	*/
endprogram: test