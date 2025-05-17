set search_path ". ../inputs/lib"
set link_library tiny.db
read_file -format verilog -top top -netlist ls1.v
read_upf ls1.upf
check_lp -stage upf 
check_lp -stage design 
report_lp -file report_lp.summary.log
report_lp -verbose -file report_lp.detailed.log
quit
