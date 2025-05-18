# Makefile for VCS-NLP Lab2
LAB_DIR = lab2
RTL_DIR= ../../rtl
RTL= ../../rtl/router.sv
SVTB = ./router_test_top.sv ./test.sv
UPF_FILE = router.upf
seed = 1
run_opts += +fsdb+mda
comp_opts = 

default: test 

test: compile run

run:
	./simv -l simv.log +ntb_random_seed=$(seed) $(run_opts)

compile:
	vcs -l vcs.log +define+UPF -sverilog -power_top router -debug_access+all -timescale="1ns/10ps" -upf $(UPF_FILE) $(SVTB) $(RTL_DIR)/*.sv +vcs+vcdpluson -kdb -lca -full64 $(comp_opts)

noupf compile_noupf:
	vcs -l vcs.log -sverilog -debug_access+all -timescale="1ns/10ps" $(SVTB) $(RTL_DIR)/*.sv +vcs+vcdpluson -full64 $(comp_opts)

verdi:
	verdi -undockWin -ssf novas.fsdb -nologo &

verdi_nokdb:
	verdi -sverilog -upf $(UPF_FILE) $(SVTB) $(RTL_DIR)/*.sv -ssf novas.fsdb -undockWin -workMode powerDebug & 

dve:
	dve -vpd vcdplus.vpd $(options) &

verdi_debug:
	./simv -l simv.log -gui=verdi +ntb_random_seed=$(seed)

debug:
	./simv -l simv.log -gui=dve +ntb_random_seed=$(seed)

solution: clean
	cp -f ../../solutions/$(LAB_DIR)/*.sv .
	cp -f ../../solutions/$(LAB_DIR)/*.upf .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log *hdrs.h *.fsdb verdiLog novas.* *.dat mvsim_native_reports elabcomLog *.xml mvdir *.ccf upf2tdcLog

nuke: clean
	rm -rf *.v* *.sv include .*.lock .*.old DVE* *.tcl *.h *.dat *.upf *.txt

original: nuke
	cp -f ../../solutions/$(LAB_DIR)/router_test_top.sv router_test_top.sv
	cp -f ../../solutions/$(LAB_DIR)/test.sv test.sv
	cp -f ../../solutions/$(LAB_DIR)/router.upf.orig router.upf
	cp -f ../../solutions/$(LAB_DIR)/decoder.upf.orig decoder.upf
	cp -f ../../solutions/$(LAB_DIR)/arbiter.upf.orig arbiter.upf

help:
	@echo ===============================================================================
	@echo  " 								       "
	@echo  " USAGE: make target <seed=xxx>                                         "
	@echo  " 								       "
	@echo  " ------------------------- Test TARGETS ------------------------------ "
	@echo  " test       => Compile TB and DUT files, Run the simulation. Generate dve and verdi output.          "
	@echo  " compile    => Compile TB and DUT with UPF."
	@echo  " noupf      => Compile TB and DUT without UPF."
	@echo  " run        => Run the simulation, Generate dve and verdi output.                                     "
	@echo  " dve        => Run dve in post-processing mode.          "
	@echo  "                                                                       "
	@echo  " verdi      => Run verdi in post-processing mode.          "
	@echo  " verdi_gui  => Run simulation interactively with verdi.                  "
	@echo  "               All verdi targets must have Verdi installed.          "
	@echo  "                                                                       "
	@echo  " debug      => Runs simulation interactively with dve.                  "
	@echo  " clean      => Remove all intermediate simv and log files.             "
	@echo  "                                                                       "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ------------------------- "
	@echo  " help       => Displays this message.                                  "
	@echo  " solution   => Copies all files from solutions directory.               "
	@echo  " nuke       => Erase all files except Makefile. "
	@echo  " original   => Erase all files except Makefile. Put directory in original state. "
	@echo  "								       "
	@echo ===============================================================================