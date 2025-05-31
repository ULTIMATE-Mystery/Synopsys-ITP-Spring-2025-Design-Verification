# constraint.con

reset_design;	 # Good practice step

# common values
set ALL_INP_EXC_CLK [remove_from_collection [all_inputs] [get_ports clk]]


# clock constraints
set CLK_PERIOD          4.0;   # Clock period
set CLK_SKEW            0.2;   # Pre-Layout clock skew includes jitter and margin
set CLK_INT_LATENCY     0.1;   # Pre-Layout latency from pin to register clock pin
set CLK_SOURCE_LATENCY  0.3;   # External clock latency from external source of clock to design clock port
set CLK_TRANSITION      0.02;  # Clock rise and fall transition times at the register clock pin

create_clock -period $CLK_PERIOD [get_ports clk]
set_clock_uncertainty -setup $CLK_SKEW [get_clocks clk]
set_clock_latency -max $CLK_INT_LATENCY [get_clocks clk]
set_clock_latency -source -max $CLK_SOURCE_LATENCY [get_clocks clk]
set_clock_transition -max $CLK_TRANSITION [get_clocks clk]

# input output delay constraints
set EXTERNAL_CLK2Q  0.6;  # Assume slowest external register driving design input port (timing from source of driving clock to signal arriving at design input port)
set EXTERNAL_SETUP  0.8;  # Assume slowest external register sampling design output port (timing from source of capture clock to signal settling at design output port)

suppress_message TIM-212; # suppress message on missing min delay - Not needed
set_input_delay -max $EXTERNAL_CLK2Q -clock clk $ALL_INP_EXC_CLK
set_output_delay -max $EXTERNAL_SETUP -clock clk [all_outputs]


# load constraints
set LIB_NAME saed32hvt_ss0p75v125c
set CELL INVX0_HVT
set LOAD_CELL $LIB_NAME/$CELL
set LOAD_CELL_INPUT_PIN $LOAD_CELL/A
set LOAD_CELL_OUTPUT_PIN $LOAD_CELL/Y

set MAX_INPUT_LOAD [expr {[load_of $LOAD_CELL_INPUT_PIN] * 10}]

suppress_message UID-401; # suppress message on using library cell as driving cell
set_driving_cell -library $LIB_NAME -lib_cell $CELL $ALL_INP_EXC_CLK
set_max_capacitance $MAX_INPUT_LOAD $ALL_INP_EXC_CLK
set_load [expr {[load_of $LOAD_CELL_INPUT_PIN] * 3}] [all_outputs]