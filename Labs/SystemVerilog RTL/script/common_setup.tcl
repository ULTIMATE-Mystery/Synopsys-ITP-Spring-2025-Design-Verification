# common_setup.tcl
set REF_LIB                       "../../ref/SAED32_2012-12-25"

set DESIGN_REF_STDHVT_PATH        "$REF_LIB/lib/stdcell_hvt"

set ADDITIONAL_SEARCH_PATH        "./rtl ./mapped ./unmapped ./script ../"  ;# Directories containing logical libraries,

set ADDITIONAL_SEARCH_PATH        [ join "
                                           ${ADDITIONAL_SEARCH_PATH}
                                           ${DESIGN_REF_STDHVT_PATH}/db_nldm
                                           ${DESIGN_REF_STDHVT_PATH}/verilog
                                                                             " ]

#	setup hold setup_tempinv hold_tempinv leakage
#
set TARGET_LIBRARY_FILES     [join " saed32hvt_ss0p75v125c.db "]

#set SYMBOL_LIBRARY_FILES          sc.sdb     ;#  Symbol library file

set VERILOG_LIBRARY_FILES          saed32nm.v     ;#  Verilog library file