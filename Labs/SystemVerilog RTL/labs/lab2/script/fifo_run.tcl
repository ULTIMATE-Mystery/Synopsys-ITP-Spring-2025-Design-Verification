# fifo_run.tcl

source ../../script/common_setup.tcl
source ../../script/dc_setup.tcl

set param_list "WIDTH=$_width, BUF_SIZE=$_size"

# Lab 2 Task 8 Step 2
#
# Perform three changes:
# One   - add the wrapper_fifo.sv file to the analyze list.
# Two   - change the elaborate command to elaborate the wrapper_fifo.
# Three - add a current_design command to set the current design to the fifo with new name (with the parameter).
#
# ToDo:
analyze -format sverilog { fifo_io.sv fifo.sv }
elaborate fifo -param $param_list


link

write_file -format verilog -output unmapped/fifo_unmapped.v
write_file -format ddc     -output unmapped/fifo_unmapped.ddc

check_design -html check_design.html

source ../../script/constraint.tcl

compile_ultra

write_file -format verilog -output mapped/fifo_mapped.v
write_file -format ddc -output mapped/fifo_mapped.ddc

# The following is for simulation

# Procedure for retrieving design from memory
proc get_design_from_inst { inst } {
  return [get_attribute [get_cells $inst] ref_name]
}

# Lab 2 Task 9 Step 2
#
# Perform three changes:
# One   - set current design back to the wrapper module.
# Two   - extract the fifo instance from the wrapper module.
# Three - write out the fifo instance as a SystemVerilog module.
#
# ToDo:



exit