# Makefile for VCS-NLP Lab3
LAB_DIR = lab3
RTL_DIR= ../../rtl
RTL= ../../rtl/router.sv
SVTB = ./router_test_top.sv ./test.sv
UPF_FILE = router.upf
seed = 1
run_opts += +fsdb+mda
comp_opts = 

default: test 

test: compile run

bad: SVTB = ./router_test_top.sv ./test_bad.sv
bad: test

rand_corrupt: run_opts+=-power power.cfg
rand_corrupt: test

run:
	./simv -l simv.log +ntb_random_seed=$(seed) $(run_opts)

compile:
	vcs -l vcs.log +define+UPF -sverilog -power_top router -debug_access+all -timescale="1ns/10ps" -upf $(UPF_FILE) $(SVTB) $(RTL_DIR)/*.sv +vcs+vcdpluson -kdb -lca -full64 $(comp_opts)

noupf compile_noupf:
	vcs -l vcs.log -sverilog -debug_access+all -timescale="1ns/10ps" $(SVTB) $(RTL_DIR)/*.sv +vcs+vcdpluson -full64 $(comp_opts)

verdi:
	verdi -undockWin -ssf novas.fsdb -nologo &

verdi_cov:
	verdi -cov -covdir simv.vdb

urg:
	urg -dir simv.vdb -lpcov
	firefox urgReport/dashboard.html

dve:
	dve -vpd vcdplus.vpd $(options) &

verdi_debug:
	./simv -l simv.log -gui=verdi +ntb_random_seed=$(seed)

debug:
	./simv -l simv.log -gui=dve +ntb_random_seed=$(seed)

solution: clean
	cp -f ../../solutions/$(LAB_DIR)/*.sv .
	cp -f ../../solutions/$(LAB_DIR)/*.upf .
	cp -f ../../solutions/$(LAB_DIR)/*.cfg .
	cp -f ../../solutions/$(LAB_DIR)/router.f .
	cp -f ../../solutions/$(LAB_DIR)/test_bad.rc .
	cp -f ../../solutions/$(LAB_DIR)/decoder_PD0_rand_corrupt.rc .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log *hdrs.h *.fsdb verdiLog novas.* *.dat mvsim_native_reports elabcomLog *.xml mvdir *.ccf upf2tdcLog

nuke: clean
	rm -rf *.v* *.sv include .*.lock .*.old DVE* *.tcl *.h *.dat *.cfg *.f *.rc *.upf *.txt *rtdb .vcst*

original: nuke
	cp -f ../../solutions/$(LAB_DIR)/router_test_top.sv router_test_top.sv
	cp -f ../../solutions/$(LAB_DIR)/test.sv.orig test.sv
	cp -f ../../solutions/$(LAB_DIR)/*.upf  .
	cp -f ../../solutions/$(LAB_DIR)/test_bad.sv test_bad.sv
	cp -f ../../solutions/$(LAB_DIR)/test_bad.rc test_bad.rc
	cp -f ../../solutions/$(LAB_DIR)/decoder_PD0_rand_corrupt.rc decoder_PD0_rand_corrupt.rc
	cp -f ../../solutions/$(LAB_DIR)/router.f router.f

help:
	@echo ===============================================================================
	@echo  " 								       "
	@echo  " USAGE: make target <seed=xxx>                                         "
	@echo  " 								       "
	@echo  " ------------------------- Test TARGETS ------------------------------ "
	@echo  " test       => Compile TB and DUT files, Run the simulation. Generate dve and verdi output.          "
	@echo  " compile    => Compile TB and DUT with UPF."
	@echo  " noupf      => Compile TB and DUT without UPF."
	@echo  " run        => Run the simulation, Generate dve and Verdi output.                                     "
	@echo  " bad => Compile and run simulation with known bad test, Generate dve and Verdi output.                                     "
	@echo  " rand_corrupt => Compile and run simulation for random power corruption, Generate dve and Verdi output.                                     "
	@echo  " dve        => Run dve in post-processing mode.          "
	@echo  "                                                                       "
	@echo  " verdi      => Run Verdi (only with KDB).                "
	@echo  " verdi_gui  => Run simulation interactively with verdi.                  "
	@echo  "               All Verdi targets must have Verdi installed.          "
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