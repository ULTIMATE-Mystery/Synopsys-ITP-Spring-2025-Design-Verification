set_fml_appmode COV

########################################################
## Setup Specific to DUT
########################################################
set design traffic

########################################################
## Reading Simulation Coverage Database
########################################################
read_covdb -cov_input simv.vdb -cov_dut TB.T1

########################################################
## Compile & Setup
########################################################
# Compilation Step 
read_file -top $design -format sverilog \
  -vcs {-f ../design/filelist} -cov all

# Clock Definitions
create_clock clk -period 100
# Reset Definitions
create_reset rst -sense high

# Initialization Commands
sim_run -stable
sim_save_reset

# Enabling Trace for Covered Goals
set_fml_var fml_cov_gen_trace on 

########################################################
## Proof
########################################################
check_fv -block 

########################################################
## Reports
########################################################
report_fv -list > results.txt

########################################################
## Saving Coverage Database and Exclusion File
########################################################
save_covdb -name cov -status covered -overwrite
save_cov_exclusion -file unr.el

########################################################
## Saving Session
########################################################
save_session -session batch_results 

