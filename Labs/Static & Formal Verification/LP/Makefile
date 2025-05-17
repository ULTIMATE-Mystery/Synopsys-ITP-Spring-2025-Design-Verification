help:
	-@echo "######################################################################"
	-@echo "FROM EACH test_<name> DIRECTORY...."
	-@echo "make vcst    	=> Run VC Static on current testcase"
	-@echo "make mvrc   	=> Run MVRC on current testcase"
	-@echo "make clean  	=> Clean up current testcase directory"
	-@echo "FROM examples DIRECTORY...."
	-@echo "make all  		=> Run VCST & MVRC on all  testcases"
	-@echo "make allclean	=> Clean up current all testcase directories"
	-@echo "make help   	=> Generate this help menu      "
	-@echo "NOTE: Refer to README file for more details on the testcase"
	-@echo "######################################################################"

vcst:
	$(VC_STATIC_HOME)/bin/vc_static_shell -file vcst.tcl -output_log_file vcst.screen.log

mvrc:
	-/bin/ln -s ../inputs/archpro.ini
	mvrc < mvrc.tcl | tee mvrc.screen.log

all:
	cd test_iso1; make vcst mvrc
	cd test_iso2; make vcst mvrc
	cd test_ls1; make vcst mvrc
	cd test_psw1; make vcst mvrc
	cd test_ret1; make vcst mvrc

allclean:
	cd test_iso1; make clean
	cd test_iso2; make clean
	cd test_ls1; make clean
	cd test_psw1; make clean
	cd test_ret1; make clean

clean:
	-@rm -rf upf_command.log
	-@rm -rf vcst_rtdb
	-@rm -rf vcst_command.log
	-@rm -rf db_read.log
	-@rm -rf lib.defs
	-@rm -rf vlogImport.log
	-@rm -rf detail.log
	-@rm -rf summary.log
	-@rm -rf ARCH_ImplicitConn.upf 
	-@rm -rf mvrc.stdout
	-@rm -rf check_design.log
	-@rm -rf report_lp.txt
	-@rm -rf apdb
	-@rm -rf mvreports
	-@rm -rf archpro.ini
	-@rm -rf *.screen.log
	-@rm -rf report_lp.*.log
	-@rm -rf *.log
