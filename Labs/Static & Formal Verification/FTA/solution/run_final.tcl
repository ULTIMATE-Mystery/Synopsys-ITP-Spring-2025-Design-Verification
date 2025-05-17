set_fml_appmode FPV

########################################################
## Setup Specific to DUT
########################################################
set design traffic

########################################################
## Compile & Setup
########################################################
# Compilation Step 
read_file -top $design -format sverilog -sva \
  -vcs {-f ../design/filelist +define+INLINE_SVA \
  ../sva/traffic.sva ../sva/bind_traffic.sva} \
  -inject_fault all

# Clock Definitions 
create_clock clk -period 100
# Reset Definitions 
create_reset rst -sense high

# Additional Properties
fvassert s_rst -expr {($past(rst) |-> s_reg==1'b0)}
fvassert s_wma -expr {(##1 s_reg==$past(waiting_main))}

# Initialisation Commands 
sim_run -stable
sim_save_reset

########################################################
## Proof
########################################################
check_fv -block 

########################################################
## FTA Flow
########################################################
# Launch FTA App
set_fml_appmode FTA

# FTA Proof & Reports
compute_fta -par_task FPV -run_finish {report_fv -list > results.txt}
