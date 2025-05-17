set defines  $::env(STEP_DEFINE)

if {$defines == 1} {
    set def_opt "+define+step1"
} elseif {$defines == 2} {
    set def_opt "+define+step2"
} elseif {$defines == 3} {
    set def_opt "+define+step3"
} elseif {$defines == 4} {
    set def_opt "+define+step4"
} elseif {$defines == 5} {
    set def_opt "+define+step5"
}

set DESIGN_DIR ../design
set ASSERTION_DIR ../sva

set top fifo

set vcs "\
${def_opt} \
${DESIGN_DIR}/fifo.v \
-sverilog \
${ASSERTION_DIR}/fifo_bind.sv \
${ASSERTION_DIR}/fifo_sva.sv \
"

set_fml_var fml_enable_prop_density_cov_map true  
set_fml_var fml_reset_property_check true

read_file -top $top -format sverilog -cov line -inject_fault all -sva -vcs $vcs

create_clock clk -period 100

create_reset resetn -sense low
sim_run -stable
sim_save_reset


if {[info exists env(BATCH)]} {
    if {$defines == 1} {
	analyze_fv_coverage
	report_fv_coverage
	report_fv_coverage -list_uncovered > pd_uncovered_report.txt
	save_property_density_results -db_name PD.vdb
	#view_coverage -cov_input PD.vdb
	exit
    }
    if {$defines == 2} {
	compute_over_constraint -par_task FPV
	save_over_constraint_results
	exit
    }
    if {$defines == 3} {
	check_fv -block
	compute_formal_core
	report_formal_core -complement -verbose > outside_formal_core.txt
	save_formal_core_results
	exit
    }

    if {$defines == 4} {
	check_fv -block
	set_fml_appmode FTA
	compute_fta -block
	report_fv -status non_detected -verbose > non_detected_faults.txt
	exit
    }

    if {$defines == 5} {
	check_fv -block
	set_fml_appmode FTA
	compute_fta -block
	report_fv -status non_detected -verbose > non_detected_faults.txt
	exit
    }
}
	
