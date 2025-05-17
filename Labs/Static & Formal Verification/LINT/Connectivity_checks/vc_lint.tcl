set search_path "./"
set link_library " "
set enable_lang_checker true
set synth_preserve_sequential  true
set_app_var sync_reset_signal_threshold 0
set_app_var analyze_skip_translate_body true
compress_hdl -enable
analyze -format verilog -vcs "Connectivity_checks.v "
elaborate top
configure_hdl_tag -enable -tag CONN_NET_UNDRIVEN 

check_hdl -lang -structure
report_hdl -file report_soc.txt -verbose
quit
