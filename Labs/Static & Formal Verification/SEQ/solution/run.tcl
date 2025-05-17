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

# Compile the two designs
analyze -format sverilog -library spec ../design/rtl1.v
analyze -format sverilog -library impl ../design/rtl1cg_bad.v
elaborate_seq -spectop mul -impltop mul

# Map inputs, outputs and blackboxes of the two design
map_by_name

## Create clock and reset signals
create_clock -period 100 spec.clk
create_reset spec.rst -sense low

## Run reset simulation
sim_run -stable
sim_save_reset

#use SEQ config to map uninitialized registers
seq_config -map_uninit -map_x zero

# Run check command
#check_fv 

