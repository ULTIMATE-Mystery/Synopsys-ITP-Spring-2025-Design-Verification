`ifdef MODULE
module test(router_io.TB rtr_io);
`else
program automatic test(router_io.TB rtr_io);
`endif
  int run_for_n_packets;  // number of packets to test
  bit[3:0] sa;      // source address
  bit[3:0] da, da_tmp;       // destination address
  logic[7:0] payload[$];    // expected packet data array
  logic[7:0] pkt2cmp_payload[$];  // actual packet data array

  initial begin
    $vcdpluson;
    run_for_n_packets = 2000;
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
    $finish;
  end

  task reset();
    rtr_io.reset_n <= 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
    ##2 rtr_io.cb.reset_n <= 1'b1;

//Part B Task 3 Step 3 -  Change repeat(15) to repeat(14)
//ToDo
    // repeat(14) @(rtr_io.cb);
//Part B Task 8 Step 2 -  Change repeat(14) to repeat(15)
//ToDo - Do only in Task 8
    repeat(15) @(rtr_io.cb);
  endtask

  task gen();
    sa = $urandom;
    da = $urandom;
    payload.delete();
    repeat($urandom_range(2,4))
      payload.push_back($urandom);
  endtask

  task send();
    send_addrs();
    send_pad();
    send_payload();
  endtask

  task send_addrs();
    rtr_io.cb.frame_n[sa] <= 1'b0;
    for(int i=0; i<4; i++) begin
      rtr_io.cb.din[sa] <= da[i];
      @(rtr_io.cb);
    end
  endtask

  task send_pad();
    rtr_io.cb.frame_n[sa] <= 1'b0;
    rtr_io.cb.valid_n[sa] <= 1'b1;
    rtr_io.cb.din[sa] <= 1'b1;
    repeat(5) @(rtr_io.cb);
  endtask

  task send_payload();
    foreach(payload[index]) begin
      for(int i=0; i<8; i++) begin
        rtr_io.cb.din[sa] <= payload[index][i];
        rtr_io.cb.valid_n[sa] <= 1'b0;
        rtr_io.cb.frame_n[sa] <= (index == (payload.size() - 1)) && (i == 7);
        @(rtr_io.cb);
      end
    end
    rtr_io.cb.valid_n[sa] <= 1'b1;
  endtask

  task recv();
    get_payload();
  endtask

//---------------------------------------------------------------------------------
//
// Add your immediate assertion statements in the blank lines of the following task
//
//---------------------------------------------------------------------------------

  task get_payload();
  automatic int brk = 0;
    pkt2cmp_payload.delete();
    @(negedge rtr_io.cb.frameo_n[da]);
    forever begin: payload
      logic[7:0] datum;
      for (int i=0; i<8; ) begin: get_byte
        if (!rtr_io.cb.valido_n[da]) begin: valid
          datum[i++] = rtr_io.cb.dout[da];


          begin logic dout;  dout = rtr_io.cb.dout[da];
//Part A Task 2 Step 2 - Add immediate assert statement to check
//and print error message if the dout signal from the DUT contains unknowns.
//Use a local copy(dout) to enhance debugability in Verdi.
//ToDo
					Unknown_dout: assert(!$isunknown(dout))
					else 
					$error("[ERROR]:%t (%m) X in output port %0d", $realtime, da);
          end
        end
        if (rtr_io.cb.frameo_n[da])
          if (i == 8) begin
            pkt2cmp_payload.push_back(datum);
            brk = 1;
            break;
          end
          else begin
            $display("\n%m\n[ERROR]%t Packet payload not byte aligned!\n", $realtime);
            $finish;
          end
        @(rtr_io.cb);
      end: get_byte
      if (brk) break;
      pkt2cmp_payload.push_back(datum);
    end
  endtask

  function bit compare(ref string message);
    if (payload.size() != pkt2cmp_payload.size()) begin
      message = "Payload Size Mismatch:\n";
      message = { message, $psprintf("payload.size() = %0d, pkt2cmp_payload.size() = %0d\n", payload.size(), pkt2cmp_payload.size()) };
      return(0);
    end
    foreach(payload[i]) begin
      if (payload[i] != pkt2cmp_payload[i]) begin
        message = "Payload Content Mismatch:\n";
        foreach(payload[i])
          message = { message, $psprintf("payload[%0d] = %0d,\tpkt2cmp_payload[%0d] = %0d\n", i, payload[i], i, pkt2cmp_payload[i]) };
        return(0);
      end
    end
    message = "Successfully Compared";
    return(1);
  endfunction

  task check();
    string message;
    static int pkts_checked = 0;
    if (!compare(message)) begin
      $display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
      $finish;
    end
    $display("[NOTE]%t Packet #%0d %s", $realtime, pkts_checked++, message);
  endtask

`ifdef MODULE
endmodule
`else
endprogram: test
`endif