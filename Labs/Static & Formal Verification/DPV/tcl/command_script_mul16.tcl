set _hector_comp_use_new_flow true
set _hector_softfloat_version custom


proc compile_spec {} {
    create_design -name spec -top hector_wrapper
    cppan -I../softfloat-3e/source/include \
        -I../softfloat-3e/source/8086 \
        -I../softfloat-3e/build/HECTOR \
        ../c/mul16.cc \
        ../softfloat-3e/source/f16_mul.c \
        ../softfloat-3e/source/f32_mul.c \
        ../softfloat-3e/source/f64_mul.c \
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
        ../softfloat-3e/source/softfloat_state.c

    compile_design spec
}

proc compile_impl {} {
    create_design -name impl -top fmul -clock clock -reset resetN -negReset

    set_cutpoint fmul.mpier_mantissa_0
    set_cutpoint fmul.mpcand_mantissa_0

    vcs -sverilog -pvalue+SIZE=16 -f ../rtl/files_a

    compile_design impl
}

proc ual {} {
    assume impl.go(1) == 1

    map_by_name -inputs -specphase 1 -implphase 1

    assume spec.rounding_mode(1) < 4
 
    assume impl.product_mantissa_0(3) == impl.mpier_mantissa_0(3) * impl.mpcand_mantissa_0(3)

    set_hector_multiple_solve_scripts true
    set_hector_multiple_solve_scripts_list [list orch_multipliers]

    lemma check = spec.product(1) == impl.product(7)

    lemma inexact =   spec.exceptions[0](1) == impl.exceptions[0](7)
    lemma underflow = spec.exceptions[1](1) == impl.exceptions[1](7)
    lemma overflow =  spec.exceptions[2](1) == impl.exceptions[2](7)
    lemma infinity =  spec.exceptions[3](1) == impl.exceptions[3](7)
    lemma invalid =   spec.exceptions[4](1) == impl.exceptions[4](7)
}

proc hdps_ual {} {
    cutpoint mpier = impl.mpier_mantissa_0(1)
    cutpoint mpcand = impl.mpcand_mantissa_0(1)

    lemma check_mul = impl.product_mantissa_0(1) == mpier * mpcand
}

proc case_split_16 {} {
    caseSplitStrategy basic

    caseBegin dnorm_norm_16
    caseAssume (spec.multiplier(1)[14:10] == 5'h00)
    caseAssume (spec.multiplicand(1)[14:10] != 5'h00)
    caseAssume (spec.multiplicand(1)[14:10] != 5'h1f)

    caseBegin norm_dnorm_16
    caseAssume (spec.multiplier(1)[14:10] != 5'h00)
    caseAssume (spec.multiplier(1)[14:10] != 5'h1f)
    caseAssume (spec.multiplicand(1)[14:10] == 5'h00)

    caseBegin A_inf_NaN_16
    caseAssume (spec.multiplier(1)[14:10] == 5'h1f)

    caseBegin B_inf_NaN_16
    caseAssume (spec.multiplicand(1)[14:10] == 5'h1f)

    caseBegin dnorm_dnorm_16
    caseAssume (spec.multiplier(1)[14:10] == 5'h00)
    caseAssume (spec.multiplicand(1)[14:10] == 5'h00)

    caseBegin norm_norm_16
    caseAssume (spec.multiplier(1)[14:10] != 5'h00)
    caseAssume (spec.multiplier(1)[14:10] != 5'h1f)
    caseAssume (spec.multiplicand(1)[14:10] != 5'h00)
    caseAssume (spec.multiplicand(1)[14:10] != 5'h1f)
}

proc make {} {
    compile_spec
    compile_impl
    compose
}

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
    set_user_assumes_lemmas_procedure "ual"
    set_hector_case_splitting_procedure "case_split_16"
    solveNB p

}
