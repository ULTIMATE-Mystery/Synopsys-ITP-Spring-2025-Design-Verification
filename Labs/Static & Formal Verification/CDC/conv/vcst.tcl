set_app_var enable_cdc true
analyze -format verilog *.v
elaborate test
read_sdc clk.sdc
check_cdc
report_cdc -file report_cdc.summary.log
report_cdc -verbose -file report_cdc.detailed.log
#quit
