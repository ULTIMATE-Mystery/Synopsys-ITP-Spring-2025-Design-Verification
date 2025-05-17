set_fml_appmode FSV

########################################################
## Setup Specific to DUT
########################################################
set design aes

########################################################
## Compile & Setup
########################################################
# Compilation Step 
read_file -top $design -format sverilog \
-vcs {-f ../design/filelist +incdir+../design}

# Clock Definitions
create_clock clk -period 100
# Reset Definitions
create_reset reset -sense low

# Initialization Commands
sim_run -stable 
sim_save_reset

########################################################
## Security Properties Specification 
########################################################
# Adding Security Properties
fsv_generate -name sub1state \
-src [get_attribute [get_ports -word \
-filter {direction==in}] full_name] \
-dest sub1.state

fsv_generate -name key_reg \
-src aes.ks1.key_reg -dest data_o

# Reporting Security Properties
fsv_report -list

########################################################
## Proof
########################################################
check_fv -block 

########################################################
## Reports
########################################################
report_fv -list

########################################################
## Saving Session
########################################################
save_session

