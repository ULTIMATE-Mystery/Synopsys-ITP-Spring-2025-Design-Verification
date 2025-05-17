#
# *********************************************************************
# * SYNOPSYS CONFIDENTIAL                                             *
# *                                                                   *
# * This is an unpublished, proprietary work of Synopsys, Inc., and   *
# * is fully protected under copyright and trade secret laws. You may *
# * not view, use, disclose, copy, or distribute this file or any     *
# * information contained herein except pursuant to a valid written   *
# * license from Synopsys.                                            *
# *********************************************************************

set_fml_appmode SEQ

seq_config -map_uninit -map_x zero -specprefix sp -implprefix im
# Compile the two designs
read_file -sva -top wrapper -vcs {-sverilog ../design/rtl1.v ../design/rtl1cg_bad1.v ../design/wrapper.v}

# Map inputs, outputs and blackboxes of the two design
map_by_name -output 

## Create clock and reset signals
create_clock -period 100 sp.clk
create_reset sp.rst -sense low

## Run reset simulation
sim_run -stable
sim_save_reset

# Run check command
check_fv 

