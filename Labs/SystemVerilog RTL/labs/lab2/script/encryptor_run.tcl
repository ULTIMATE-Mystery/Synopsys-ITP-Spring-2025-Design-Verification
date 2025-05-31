# encryptor_run.tcl

source ../../script/common_setup.tcl
source ../../script/dc_setup.tcl

set param_list "WIDTH=$_width, BUF_SIZE=$_size"

analyze -format sverilog { fifo_io.sv encryptor.sv wrapper_encryptor.sv }
elaborate wrapper_encryptor -param $param_list
link

remove_design [get_designs fifo*]
read_ddc fifo_mapped.ddc

current_design [get_designs encryptor*]

write_file -format verilog -output unmapped/encryptor_unmapped.v
write_file -format ddc -output unmapped/encryptor_unmapped.ddc

check_design -html check_design.html

source ../../script/constraint.tcl

compile_ultra

write_file -format verilog -output mapped/encryptor_mapped.v
write_file -format ddc -output mapped/encryptor_mapped.ddc

# The following is for simulation

# Procedure for retrieving design from memory
proc get_design_from_inst { inst } {
  return [get_attribute [get_cells $inst] ref_name]
}

current_design [get_designs wrapper_encryptor*]

set dut [get_design_from_inst encryptor_inst]
write_file -format svsim -output wrapper/encryptor_wrapper.sv $dut

exit