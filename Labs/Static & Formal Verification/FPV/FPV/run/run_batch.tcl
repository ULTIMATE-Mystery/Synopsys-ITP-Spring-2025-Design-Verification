set_fml_appmode FPV

########################################################
## Setup Specific to DUT
########################################################
set design traffic

########################################################
## Compile & Setup
########################################################
# Compilation Step
# Option 1: Use read_file for unified read-compile-elaborate
# Compile and elaborate the design and SVA files in one command using 'read_file' 
read_file -top $design -format sverilog -sva -vcs {-f ../design/filelist +define+INLINE_SVA ../sva/traffic.sva ../sva/bind_traffic.sva}

# Option 2: Use analyze + elaborate for unified usage model
# This alternative splits the compilation into two steps
# analyze -format sverilog -vcs {-f ../design/filelist +define+INLINE_SVA ../sva/traffic.sva ../sva/bind_traffic.sva}
# elaborate $design -sva

# Clock Definitions 
create_clock clk -period 100
# Reset Definitions 
create_reset rst -sense high

# Initialisation Commands 
sim_run -stable
sim_save_reset

########################################################
## Proof
########################################################
check_fv -block 

########################################################
## Reports
########################################################
report_fv -list > results.txt

########################################################
## Save Session
########################################################
save_session -session batch_results