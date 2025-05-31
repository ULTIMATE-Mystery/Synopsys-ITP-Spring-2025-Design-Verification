REF_LIB                  = ../../ref/SAED32_2012-12-25
DESIGN_REF_STDHVT_PATH   = ${REF_LIB}/lib/stdcell_hvt
hvt_library              = ${DESIGN_REF_STDHVT_PATH}/verilog/saed32nm_hvt.v
DW                       = ${SYNOPSYS}/dw/sim_ver
original_path            = ../../.original/lab2
solution_path            = ../../.solution/lab2

test           = test_top
test_path      = ./test

rtl_path       = ./rtl
gate_path      = ./mapped
GATE           = ${gate_path}/${rtl}_mapped.v
DUT_GATE       = ${rtl_path}/fifo_io.sv ${GATE}
TEST_TOP       = ${test_path}/${rtl}_${test}.sv

bin            = simv

rtl            = encryptor
DUT            = ${rtl_path}/fifo_io.sv ${rtl_path}/${rtl}.sv

WIDTH          = 8
BUF_SIZE       = 16
script         = ${rtl}_run

log            = ${bin}
rtl_log        = ${log}.log
gate_log       = ${log}_gate.log
ddc            = ${rtl}_unmapped

seed           = 1
defines        =
plus           = 

# simulation switches
compile_switches      = -sverilog +vcs+vcdpluson -timescale="1ns/100ps" -l comp.log -o ${bin}    -y ${DW} +libext+.v+.sv+ +incdir+${DW}+${rtl_path}+ +define+DESIGN=${rtl}+${defines}+                    -pvalue+${rtl}_${test}.WIDTH=${WIDTH} -pvalue+${rtl}_${test}.BUF_SIZE=${BUF_SIZE} ${DUT}      ${TEST_TOP}
compile_switches_gate = -sverilog +vcs+vcdpluson -timescale="1ns/100ps" -l comp.log -o simv_gate -v ${hvt_library}                                   +define+DESIGN=${rtl}+GATE+${defines}+ +warn=noTFIPC -pvalue+${rtl}_${test}.WIDTH=${WIDTH} -pvalue+${rtl}_${test}.BUF_SIZE=${BUF_SIZE} ${DUT_GATE} ${TEST_TOP}

# simulation switches
runtime_switches = +${plus}

sim: compile run_rtl

gate: compile_gate run_gate

syn:
	dc_shell -x "set _rtl ${rtl}; set _size ${BUF_SIZE}; set _width ${WIDTH}; source -e -v script/${script}.tcl" | tee -i ${rtl}_run.log

dv:
	dc_shell -x "set _ddc ${ddc}; source -e -v script/dv.tcl; start_gui; gui_create_window -type Schematic -show maximized; gui_create_schematic -clct [current_design]"

compile_gate:
	vcs ${compile_switches_gate}

compile:           ${DUT}      ${TEST_TOP}
	vcs ${compile_switches}

run_rtl:
	./simv -l ${rtl_log} +vpdfile+${rtl}.vpd +ntb_random_seed=$(seed) ${runtime_switches}

run_gate:
	./simv_gate -l ${gate_log} +vpdfile+${rtl}_gate.vpd +ntb_random_seed=$(seed) ${runtime_switches}

dve:
	dve -vpd ${rtl}.vpd&

dve_gate:
	dve -vpd ${rtl}_gate.vpd&

original: nuke
	cp ${original_path}/rtl/*.* rtl
	cp ${original_path}/test/*.* test
	cp ${original_path}/script/*.* script

solution: nuke
	cp ${solution_path}/rtl/*.* rtl
	cp ${solution_path}/test/*.* test
	cp ${solution_path}/script/*.* script

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *.hvp urg* .inter.* .restart* .synopsys* novas.* *.dat *.fsdb verdi* work* vlog* *.ses.* default.* *.html *.syn *.pvl *.mr

nuke: clean
	rm -rf script/*.* rtl/*.* mapped/*.* unmapped/*.* test/*.sv

help:
	@echo =======================================================================
	@echo  " 								       "
	@echo  "  USAGE: make target <seed=xxx> <options>                              "
	@echo  " 								       "
	@echo  "  xxx is the random seed.  Can be any integer except 0. Defaults to 1  "
	@echo  " 								       "
	@echo  " ---------------------- SIMULATION TARGETS --------------------------- "
	@echo  " sim      => Compile and simulate at RTL level                         "
	@echo  " gate     => Compile and simulate at gate level                        "
	@echo  " dve      => Open DVE waveform window to see result of RTL simulation  "
	@echo  " dve_gate => Open DVE waveform window to see result of gate simulation "
	@echo  " 								       "
	@echo  " ---------------------- SIMULATION OPTIONS --------------------------- "
	@echo  " rtl      => Module name of design to be simulated                     "
	@echo  " 								       "
	@echo  " ----------------------- SYNTHESIS TARGETS --------------------------- "
	@echo  " syn      => Synthesize RTL into gate level netlist                    "
	@echo  " dv       => Open Design Vision to see logic specified by ddc switch   "
	@echo  " 								       "
	@echo  " ----------------------- SYNTHESIS OPTION --------- ------------------ "
	@echo  " rtl      => Module name of design to be synthesized                   "
	@echo  " ddc      => Logic to be shown in the Design Vision window             "
	@echo  "                                                                       "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ------------------------- "
	@echo  " help     => Displays this message                                     "
	@echo  " clean    => Remove all intermediate simv and log files                "
	@echo  " nuke     => Remove all source code and debug files                    "
	@echo  " original => Return content of lab back to original state              "
	@echo  "								       "
	@echo  " ---------------------- EMBEDDED SETTINGS -----------------------------"
	@echo  " -timescale=\"1ns/100ps\"                                              "
	@echo  " -debug_all                                                            "
	@echo =======================================================================