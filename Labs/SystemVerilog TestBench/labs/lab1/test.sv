//Lab 1 - Task 3, Step 2
//
//Declare a program block with arguments to connect
//to modport TB declared in interface
//ToDo
program automatic test(router_io.TB rtr_io);

  //Lab 1 - Task 3, Step 3
  //
  //Declare an initial block 
  //In the initial block print a simple message to the screen
  //ToDo

//initial begin
 // $display("Hello World!");
//end

  //Lab 1 - Task 6, Step 2
  //
  //Replace $display with a call to the reset() task
  //ToDo - Caution!! Do only in Task 6
  
  initial begin
    reset();
  end

  //Lab 1 - Task 6, Step 3
  //
  //Define a task called reset() inside the program to reset DUT per spec.
  //ToDo - Caution!! Do only in Task 6
  task reset();
    rtr_io.reset_n = 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
    repeat(2) @(rtr_io.cb);
    rtr_io.cb.reset_n <= 1'b1;
    repeat(15) @(rtr_io.cb);
  endtask: reset 
    
endprogram: test