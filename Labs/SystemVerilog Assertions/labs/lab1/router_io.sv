interface router_io(input bit clock);
  logic		reset_n;
  logic [15:0]	din;
  logic [15:0]	frame_n;
  logic [15:0]	valid_n;
  logic [15:0]	dout;
  logic [15:0]	valido_n;
  logic [15:0]	busy_n;
  logic [15:0]	frameo_n;

//Part B Task 1 Step 2 - Implement this reset protocol requirement with a concurrent assertion statement
//ToDo
	reset: assert property (@(posedge clock)
		$rose(reset_n) |-> not (##[0:14] ~&(frame_n))
		) else begin
		$fatal(1,"[FATAL]:%t (%m) reset violation!!!", $realtime);
		end

  clocking cb @(posedge clock);
    default input #1 output #1;
    output reset_n;
    output din;
    output frame_n;
    output valid_n;
    input dout;
    input valido_n;
    input busy_n;
    input frameo_n;
  endclocking

  modport TB(clocking cb, output reset_n);
endinterface