# Makefile for SystemVerilog Lab4
LAB = lab4
RTL= ../../rtl_lib/router.v
BADRTL= ../../rtl_lib/bad/router.v
SVTB = ./router_test_top.sv ./router_io.sv ./test.sv ./assert.sva
SVA_LIB = ${VCS_HOME}/packages/sva_cg
#this variable enables assertion successes to be displayed in Verdi
export FSDB_SVA_SUCCESS=1
seed = 1
BROWSER = firefox
DSBL_ELAB = +define+SVACG_DISABLE_ELAB_PARAM_CHECKS_assert_arbiter
override options += -suppress=FLWSA,LCA_FEATURES_ENABLED -kdb -lca

default: clean test 

test: compile run

bad: clean compile_bad run

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +fsdb+functions

compile:
	vcs -l comp.log -sverilog -debug_access+all -debug_region=cell+lib -assert dve -assert enable_diag +define+ASSERT_ON -y $(SVA_LIB) +libext+.sv +incdir+$(SVA_LIB) $(SVTB) $(RTL) $(DSBL_ELAB) $(options)

compile_bad:
	vcs -l comp.log -sverilog -debug_access+all -debug_region=cell+lib -assert dve -assert enable_diag +define+ASSERT_ON -y $(SVA_LIB) +libext+.sv +incdir+$(SVA_LIB) $(SVTB) $(BADRTL) $(DSBL_ELAB) $(options)

dve:
	dve -vpd vcdplus.vpd &

verdi:
	verdi -simBin simv -ssf novas.fsdb -undockWin -workMode assertionDebug & 

verdi_debug:
	./simv -l simv.log -gui=verdi +ntb_random_seed=$(seed)

debug:
	./simv -l simv.log -gui +ntb_random_seed=$(seed)

solution: clean
	cp ../../solutions/$(LAB)/*.sv .
	cp ../../solutions/$(LAB)/*.h .
	cp ../../solutions/$(LAB)/*.sva .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log urg* novas.* *Log vc_hdrs.h work*

nuke: clean
	rm -rf *.v* include *.sv *.sva .*.lock *.old .*.old DVE* *.tcl *.h novas.* *Log *.h

original:
	cp ../../solutions/$(LAB)/*.sv .
	cp ../../solutions/$(LAB)/*.h .
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