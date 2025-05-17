set design traffic
#add variable to enable reset prorperty check

#modify below to enable coverage for line, condition and toggle
read_file -top $design -format verilog -sva -vcs {-f ../design/filelist}

create_clock clk -period 100
create_reset rst -sense high

sim_run -stable
sim_save_reset

check_fv -block 

#add commant to compute formal core in block mode

#add command to compute formal core coverage in block mode

#add command to save formal core results to a coverage database

#add command to save uncoverable coverage goals in exclusion file


