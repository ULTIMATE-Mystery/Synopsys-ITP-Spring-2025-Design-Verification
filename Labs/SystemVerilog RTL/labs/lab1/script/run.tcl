# run.tcl

source ../../script/common_setup.tcl
source ../../script/dc_setup.tcl

set define_list "$_lang"

analyze -format sverilog -define $define_list $_rtl.sv
elaborate $_rtl

link

write_file -format verilog -output unmapped/${_rtl}_unmapped.v
write_file -format ddc     -output unmapped/${_rtl}_unmapped.ddc

source ../../script/constraint.tcl

compile_ultra

write_file -format verilog -output mapped/${_rtl}_mapped.v
write_file -format ddc     -output mapped/${_rtl}_mapped.ddc

report_qor

exit