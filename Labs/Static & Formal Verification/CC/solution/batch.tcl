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

set_fml_appmode CC
set design chip_top

# Compile the design
read_file -top $design -format verilog -vcs {../design/cctest.v  +define+RTL_BUG_FIX}

# csv parameters
load_cc_set_param csv_enable "%1%"
load_cc_set_param csv_from "%2%"
load_cc_set_param csv_to "%3%"
load_cc_set_param csv_prop_name "%4%"
load_cc_set_param csv_start_line "2"

# load csv file
load_cc -format csv cctest.csv

# load initial state 
sim_save_reset

# Run check command
check_fv  -block
report_fv > results.txt

