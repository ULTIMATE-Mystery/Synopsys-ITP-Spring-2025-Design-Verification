set_fml_appmode FPV
set design traffic
read_file -top $design -format sverilog -sva -vcs {-f ../design/filelist +define+INLINE_SVA ../sva/traffic.sva ../sva/bind_traffic.sva}
# analyze -format sverilog -vcs {-f ../design/filelist +define+INLINE_SVA ../sva/traffic.sva ../sva/bind_traffic.sva}
# elaborate $design -sva 
create_clock clk -period 100
create_reset rst -sense high
sim_run -stable
sim_save_reset
