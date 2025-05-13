# Makefile for SVA Lab2
LAB = lab2
RTL= ../../rtl/router.v
BADRTL= ../../rtl/bad/router.v
SVTB = ./router_test_top.sv ./router_io.sv ./test.sv ./assert.sva ./assert_binds.sva
#this variable enables assertion successes to be displayed in Verdi
export FSDB_SVA_SUCCESS=1
seed = 1
override options += -suppress=FLWSA,LCA_FEATURES_ENABLED -kdb -lca

default: clean test 

test: compile run

bad: compile_bad run

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +fsdb+functions

compile_no_assert:
	vcs -l comp.log -sverilog -debug_access+all $(SVTB) $(RTL) $(options)

compile:
	vcs -l comp.log -sverilog -debug_access+all $(SVTB) $(RTL) -assert dve -assert enable_diag $(options)

compile_bad:
	vcs -l comp.log -sverilog -debug_access+all $(SVTB) $(BADRTL) -assert dve -assert enable_diag $(options)

dve:
	dve -vpd vcdplus.vpd &

verdi:
	verdi -simflow -simBin simv -ssf novas.fsdb -undockWin -workMode assertionDebug & 

verdi_debug:
	./simv -l simv.log -gui=verdi +ntb_random_seed=$(seed)

debug:
	./simv -l simv.log -gui +ntb_random_seed=$(seed)

solution: clean
	cp ../../solutions/$(LAB)/*.sv .
	cp ../../solutions/$(LAB)/*.sva .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log urg* novas.* *Log

nuke: clean
	rm -rf *.v* include *.sv *.sva .*.lock *.old .*.old DVE* *.tcl urg* *.h novas.* *Log

original:
	cp ../../solutions/$(LAB)/.original/*.sv .
	cp ../../solutions/$(LAB)/.original/*.sva .

help:
	@echo ===========================================================================
	@echo  " 								        "
	@echo  " USAGE: make target <seed=xxx>                                          "
	@echo  " 								        "
	@echo  " ------------------------- Test TARGETS --------------------------------"
	@echo  " test       => Compiles TB and GOOD DUT files, runs the simulation.     "
	@echo  " bad        => Compiles TB and BAD DUT files, runs the simulation.      "
	@echo  " compile    => Compiles the TB and DUT.                                 "
	@echo  " run        => Runs the simulation.                                     "
	@echo  " dve        => Runs dve in post-processing mode                         "
	@echo  " debug      => Runs simulation interactively with dve                   "
	@echo  " verdi      => Runs Verdi3 in post-processing mode                      "
	@echo  " verdi_debug => Runs simulation interactively with Verdi3               "
	@echo  " clean      => Removes all intermediate simv and log files.             "
	@echo  "                                                                        "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ---------------------------"
	@echo  " help       => Displays this message.                                   "
	@echo  " solution   => Copies final lab solution files from solutions directory "
	@echo  " nuke       => Erases all user and generated files                      "
	@echo  " original   => Copy files required to restart lab. Usually after a nuke "
	@echo  "				     			                "
	@echo ===========================================================================