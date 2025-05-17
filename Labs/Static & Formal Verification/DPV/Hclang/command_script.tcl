# Native counter-example replay demo
#

set_app_var _hector_comp_use_new_flow true

proc regrun { t } {

    create_design spec -top main
    cppan test.cc -I../blitz-0.10 -I./blitz-0.10 -Wno-parentheses
    compile_design spec

    proof p -clocking high
#    lemma l0 = (C00(0) == A(0)[0][0] + A(0)[0][1]  + A(0)[1][0] + A(0)[1][1])
    lemma l0 = (C00(0) == A(0)[0][0] + A(0)[0][1]  + A(0)[1][0])
    prove

    set succ [getstr success]
    set fail [getstr failed]

    puts "REGINFO success $succ"
    puts "REGINFO failed  $fail"

    puts "You can now use simcex -gdb l0 to invoke the native debugger inside Hector"
    puts "    or you can use simcex -extract l0 and then invoke gdb <your executable name>"
    puts "    from the shell command-line"
    puts "    If you did not build your own native executable, you should be able"
    puts "    to find the one Hector built at SCV_WORK/spec.exe"
    
    if {$succ == "l0" && $fail == ""} {
        puts "REGPASS"
    } else {
        puts "REGFAIL"
    }
}

proc native_gdb { } {
    simcex -extract l0
}

proc hector_gdb { } {
    simcex -gdb l0
}

proc getstr { status } {
    set str ""
    foreach i [getlemmas -status $status] {
        set str "$str [lindex $i 0]"
    }
    set str [string trim $str " "]
    return $str
}
