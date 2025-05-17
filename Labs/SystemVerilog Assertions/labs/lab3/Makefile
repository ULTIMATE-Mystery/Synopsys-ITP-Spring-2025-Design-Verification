# Makefile for SVA Lab3
LAB = lab3
RTL= ../../rtl/router.v
SVTB = ./router_test_top.sv ./router_io.sv ./assert.sva ./assert_binds.sva ./test.sv
#this variable enables assertion successes to be displayed in Verdi
export FSDB_SVA_SUCCESS=1
seed = 1
BROWSER = /usr/bin/firefox
override options += -suppress=FLWSA,LCA_FEATURES_ENABLED -kdb -lca

default: test 

test: clean compile run

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +fsdb+functions -cm assert

compile:
	vcs -l comp.log -sverilog -debug_access+all $(SVTB) $(RTL) -assert dve -assert enable_diag -cm assert $(options)

compile_no_assert:
	vcs -l comp.log -sverilog -debug_access+all $(SVTB) $(RTL) $(options)

original:
	cp ../../solutions/lab2/*.sv .
	cp ../../solutions/$(LAB)/.original/assert.sva .
	cp ../../solutions/$(LAB)/assert_binds.sva .
	cp ../../solutions/$(LAB)/files .

my_copy:
	cp ../lab2/*.sv .
	cp ../lab2/*.sva .
	cp ../../solutions/$(LAB)/files .

urg:
	urg -dir simv.vdb
	urg -dir simv.vdb -format text
	$(BROWSER) urgReport/asserts.html &

coverage:
	$(BROWSER) urgReport/asserts.html &

dve_cov:
	dve -cov -dir simv.vdb &

verdi_cov:
	verdi -cov -covdir simv.vdb &

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
	cp ../../solutions/$(LAB)/files .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log urg* novas.* *Log

nuke: clean
	rm -rf *.v* include *.sv *.sva .*.lock *.old .*.old files DVE* *.tcl urg* *.h novas.* *Log

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
	@echo  " original   => Copy files required to start/restart lab. Usually after a nuke "
	@echo  " my_copy    => Copy files from your previously completed lab2 required to start/restart lab. Usually after a nuke "
	@echo  "				     			                "
	@echo ===========================================================================