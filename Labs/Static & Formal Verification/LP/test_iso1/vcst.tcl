set search_path ". ../inputs/lib"
set link_library tiny.db
read_file -format verilog -top top -netlist iso1.v
read_upf iso1.upf
check_lp -stage upf -force
check_lp -stage design -force
check_lp -stage pg -force
report_lp -file report_lp.summary.log
report_lp -verbose -file report_lp.detailed.log
quit
