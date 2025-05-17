#Source the beta variable for dashboard
#source ../sva/env.csh

#Set the design top in a variable
set top fifo

# single step analyze + elaborate
#read_file -top $top -format sverilog -sva -vcs {-f ../design/filelist.flist +define+LAB_PART_B}
read_file -top $top -format sverilog -sva -vcs {-f ../design/filelist.flist}

# define the clock
create_clock clk -period 100 -initial 0

# define the reset and active level - here it is active low
create_reset resetn -sense low

# run simulation phase for reset until the states of all regs is stable
sim_run -stable 

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
