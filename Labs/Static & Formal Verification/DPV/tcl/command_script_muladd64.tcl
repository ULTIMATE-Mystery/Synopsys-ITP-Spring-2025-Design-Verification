set _hector_comp_use_new_flow true
set _hector_softfloat_version custom

proc compile_spec {} {
    create_design -name spec -top hector_wrapper
    cppan -I../softfloat-3e/source/include \
        -I../softfloat-3e/source/8086 \
	-I../softfloat-3e/build/HECTOR \
        ../c/madd64.cc \
        ../softfloat-3e/source/f16_mulAdd.c \
        ../softfloat-3e/source/f32_mulAdd.c \
        ../softfloat-3e/source/f64_mulAdd.c \
        ../softfloat-3e/source/s_mulAddF64.c \
        ../softfloat-3e/source/s_normSubnormalF16Sig.c \
        ../softfloat-3e/source/s_normSubnormalF32Sig.c \
        ../softfloat-3e/source/s_normSubnormalF64Sig.c \
        ../softfloat-3e/source/s_shortShiftRightJam64.c \
        ../softfloat-3e/source/s_countLeadingZeros32.c \
        ../softfloat-3e/source/s_roundPackToF16.c \
        ../softfloat-3e/source/s_roundPackToF32.c \
        ../softfloat-3e/source/s_roundPackToF64.c \
        ../softfloat-3e/source/s_shiftRightJam32.c \
        ../softfloat-3e/source/s_shiftRightJam64.c \
        ../softfloat-3e/source/ARM-VFPv2/s_propagateNaNF16UI.c \
        ../softfloat-3e/source/ARM-VFPv2/s_propagateNaNF32UI.c \
        ../softfloat-3e/source/ARM-VFPv2/s_propagateNaNF64UI.c \
        ../softfloat-3e/source/ARM-VFPv2/softfloat_raiseFlags.c \
        ../softfloat-3e/source/s_countLeadingZeros8.c \
        ../softfloat-3e/source/s_countLeadingZeros16.c \
        ../softfloat-3e/source/s_countLeadingZeros64.c \
        ../softfloat-3e/source/s_mul64To128M.c \
        ../softfloat-3e/source/s_shortShiftRightM.c \
        ../softfloat-3e/source/s_addM.c \
        ../softfloat-3e/source/s_shiftRightJamM.c \
        ../softfloat-3e/source/s_subM.c \
        ../softfloat-3e/source/s_negXM.c \
        ../softfloat-3e/source/s_shiftLeftM.c \
        ../softfloat-3e/source/s_shortShiftRightJamM.c \
        ../softfloat-3e/source/s_shortShiftLeftM.c \
        ../softfloat-3e/source/softfloat_state.c

    compile_design spec
}

proc compile_impl {} {
    create_design -name impl -top muladd -clock clock -reset resetN -negReset

    set_cutpoint muladd.mpier_mantissa_0a
    set_cutpoint muladd.mpcand_mantissa_0a

    vcs -sverilog -pvalue+SIZE=64 -f ../rtl/files_muladda

    compile_design impl
}

proc ual_main {} {
    assume impl.go(1) == 1
    map_by_name -inputs -specphase 1 -implphase 1
    assume spec.rounding_mode(1) < 4
    assume impl.product_mantissa_0(3) == impl.mpier_mantissa_0a(3) * impl.mpcand_mantissa_0a(3)

    set_resource_limit 200000
    set_hector_multiple_solve_scripts true
    set_hector_multiple_solve_scripts_list [list orch_multipliers]
    set orch_solve_outputs_effort 2

    lemma rslt = spec.result(1)[7:0] == impl.result(7)[7:0]
    lemma ex = spec.exceptions(1) == impl.exceptions(7)
}

proc hdps_ual {} {
    cutpoint mpier = impl.mpier_mantissa_0a(1)
    cutpoint mpcand = impl.mpcand_mantissa_0a(1)

    lemma check_mul = impl.product_mantissa_0(1) == mpier * mpcand
}

proc case_split_64 {} {
    caseSplitStrategy basic

    caseBegin A_inf_NaN_64
    caseAssume (spec.multiplier(1)[62:52] == 11'h7ff)

    caseBegin B_inf_NaN_64
    caseAssume (spec.multiplicand(1)[62:52] == 11'h7ff)

    caseBegin C_inf_NaN_64
    caseAssume (spec.addend(1)[62:52] == 11'h7ff)

    caseBegin norm_norm_norm_64
    caseAssume (spec.multiplier(1)[62:52] != 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h7ff)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h7ff)
    caseAssume (spec.addend(1)[62:52] != 11'h000)
    caseAssume (spec.addend(1)[62:52] != 11'h7ff)
    caseEnumerate nnn1 -expr spec.multiplier[62:53] -parent norm_norm_norm_64 -type leading1
    caseEnumerate nnn2 -expr spec.multiplicand[62:53] -parent nnn1 -type leading1
    caseEnumerate nnn3 -expr spec.addend[62:53] -parent nnn2 -type leading1

    caseBegin A_dnorm_64
    caseAssume (spec.multiplier(1)[62:52] == 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h7ff)
    caseAssume (spec.addend(1)[62:52] != 11'h000)
    caseAssume (spec.addend(1)[62:52] != 11'h7ff)

    caseBegin B_dnorm_64
    caseAssume (spec.multiplicand(1)[62:52] == 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h7ff)
    caseAssume (spec.addend(1)[62:52] != 11'h000)
    caseAssume (spec.addend(1)[62:52] != 11'h7ff)

    caseBegin C_dnorm_64
    caseAssume (spec.addend(1)[62:52] == 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h7ff)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h7ff)
    caseEnumerate cdn1 -expr spec.addend[51:0] -parent C_dnorm_64 -type leading1

    caseBegin AB_dnorm_64
    caseAssume (spec.multiplier(1)[62:52] == 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] == 11'h000)
    caseAssume (spec.addend(1)[62:52] != 11'h000)
    caseAssume (spec.addend(1)[62:52] != 11'h7ff)

    caseBegin BC_dnorm_64
    caseAssume (spec.multiplicand(1)[62:52] == 11'h000)
    caseAssume (spec.addend(1)[62:52] == 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h000)
    caseAssume (spec.multiplier(1)[62:52] != 11'h7ff)
    caseEnumerate bcdn -expr spec.addend[51:0] -parent BC_dnorm_64 -type leading1

    caseBegin AC_dnorm_64
    caseAssume (spec.multiplier(1)[62:52] == 11'h000)
    caseAssume (spec.addend(1)[62:52] == 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] != 11'h7ff)
    caseEnumerate acdn -expr spec.addend[51:0] -parent AC_dnorm_64 -type leading1

    caseBegin ABC_dnorm_64
    caseAssume (spec.multiplier(1)[62:52] == 11'h000)
    caseAssume (spec.multiplicand(1)[62:52] == 11'h000)
    caseAssume (spec.addend(1)[62:52] == 11'h000)
}

proc make {} {
    compile_spec
    compile_impl
    compose
}

set_hector_sym_max_iterations 10
set_host_file "host.qsub"

proc run_hdps {} {
set_user_assumes_lemmas_procedure "hdps_ual"

set_custom_solve_script "orch_custom_bit_operations"
set_hector_rew_use_dps_engine true
set_hector_rew_dps_solve_script __hector_orch_custom_dps2
set_resource_limit 200
set_hector_rew_dps_resource_limit 1200

    run_all_hdps_options -encoding [list radix4booth] hdps -modes 0 -rrtypes false -abstypes no_abstraction
    #proofwait
}

proc run_main {} {
    set orch_solve_outputs_effort 2
    set_user_assumes_lemmas_procedure "ual_main"
    set_hector_case_splitting_procedure "case_split_64"
    solveNB p

}
