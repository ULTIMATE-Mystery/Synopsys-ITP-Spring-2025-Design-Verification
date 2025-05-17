set_fml_appmode AEP
set design traffic
read_file -top $design -format verilog \
-aep all -vcs {-f ../design/filelist}

create_clock clk -period 100 
create_reset rst -sense high

sim_run -stable 
sim_save_reset


