set design traffic
#add variable to enable reset prorperty check
set_fml_var fml_reset_property_check true
#modify below to enable coverage for line, condition and toggle
read_file -top $design -format verilog -cov line+cond+tgl -sva -vcs {-f ../design/filelist}

create_clock clk -period 100
create_reset rst -sense high

sim_run -stable
sim_save_reset

check_fv -block 

#add commant to compute formal core in block mode
compute_formal_core -property [get_props -status proven] -block
#add command to compute formal core coverage in block mode
compute_formal_core_coverage -property [get_props -status proven] -par_task FPV -block
#add command to save formal core results to a coverage database
save_formal_core_results -db_name formal_core_cov 
#add command to save uncoverable coverage goals in exclusion file
save_cov_exclusion -file uncoverables.el

