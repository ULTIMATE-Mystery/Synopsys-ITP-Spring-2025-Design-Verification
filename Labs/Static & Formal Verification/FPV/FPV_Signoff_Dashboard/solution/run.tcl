#Source the beta variable for dashboard
#source ../sva/env.csh

#Set the design top in a variable
set top fifo

# Include coverage options file "cov_options.tcl"
source ../sva/cov_options.tcl

# Configure Fault Injection in FTA
# Specify modules where faults need to be injected
fta_init -scope {fifo}

# Enable vacuity failures to be reported as Detected
#set_fml_var fml_fta_enable_vacuity_check true
signoff_config -type all
#signoff_config -type "line cond toggle branch cg fault_rtl fault_conn"
#
# single step analyze + elaborate
#read_file -top $top -format sverilog -sva  -vcs {-f ../design/filelist.flist +define+LAB_PART_B -Xnativecer=0x1}
read_file -top $top -format sverilog -sva -vcs {-f ../design/filelist.flist +define+LAB_PART_B}

# define the clock
create_clock clk -period 100 -initial 0

# define the reset and active level - here it is active low
create_reset resetn -sense low

# run simulation phase for reset until the states of all regs is stable
sim_run -stable 
#sim_set_state -uninitialized -apply 0
# save the state after simulation phase is completed
# after this formal takes over from simulation
sim_save_reset

# enable witness trace for vacuity 
set_fml_var fml_witness_on true

# enable viewing of reset + formal trace in one composite trace
set_app_var fml_composite_trace false

# Set max proof time - wall clock time
set_fml_var fml_max_time 5M

check_fv -block
