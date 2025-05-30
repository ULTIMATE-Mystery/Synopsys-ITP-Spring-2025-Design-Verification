simSetSimulator "-vcssv" -exec "simv" -args -uvmDebug on
debImport "-sverilog" "-ntb_opts" "uvm-1.2" "../../rtl/router.sv" \
          "../../rtl/router_io.sv" "../../rtl/ral/host_io.sv" \
          "../../rtl/reset_io.sv" "../../rtl/router_test_top.sv" \
          "./packages/router_stimulus_pkg.sv" "./packages/router_env_pkg.sv" \
          "./packages/router_test_pkg.sv" "./test.sv" "-l" "simv.log" \
          "+UVM_TESTNAME=test_base" "+UVM_VERBOSITY=UVM_MEDIUM" "+" "+" \
          "+UVM_TR_RECORD" "+UVM_LOG_RECORD" "+ntb_random_seed=1"
debLoadSimResult \
           ./novas.fsdb
wvCreateWindow
srcHBSelect "router_test_top.reset_if" -win $_nTrace1
wvAddSubGroup -win $_nWave2 -holdpost {reset_if(reset_io)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 0)}
wvAddSignal -win $_nWave2 "/router_test_top/reset_if/clk" \
           "/router_test_top/reset_if/reset_n"
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 0)}
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 2)}
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 2)}
wvSetPosition -win $_nWave2 {("G1" 0)}
srcHBSelect "router_test_top.router_if" -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 0)}
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 1)}
wvSetPosition -win $_nWave2 {("G1/reset_if(reset_io)" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {router_if(router_io)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 0)}
wvAddSignal -win $_nWave2 "/router_test_top/router_if/clk" \
           "/router_test_top/router_if/frame_n\[15:0\]" \
           "/router_test_top/router_if/valid_n\[15:0\]" \
           "/router_test_top/router_if/din\[15:0\]" \
           "/router_test_top/router_if/dout\[15:0\]" \
           "/router_test_top/router_if/busy_n\[15:0\]" \
           "/router_test_top/router_if/valido_n\[15:0\]" \
           "/router_test_top/router_if/frameo_n\[15:0\]"
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 0)}
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvSetPosition -win $_nWave2 {("G2" 0)}
verdiWindowResize -win Verdi_1 "213" "221" "983" "693"
verdiWindowResize -win Verdi_1 "213" "221" "983" "832"
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 8 )} 
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 8 )} 
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvExpandBus -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvZoomAll -win $_nWave2
verdiWindowResize -win $_Verdi_1 "213" "221" "1182" "863"
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 14 )} 
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 14 )} 
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 14 )} 
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 8 )} 
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvCollapseBus -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvSetPosition -win $_nWave2 {("G2/router_if(router_io)" 8)}
wvZoom -win $_nWave2 0.000000 117949.858729
wvZoom -win $_nWave2 0.000000 29636.240992
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/_vcs_msglog"
wvGetSignalSetScope -win $_nWave2 "/router_test_top/host_if"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/router_test_top/host_if/clk" \
           "/router_test_top/host_if/wr_n" "/router_test_top/host_if/rd_n" \
           "/router_test_top/host_if/address\[15:0\]" \
           "/router_test_top/host_if/data\[15:0\]"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 5)}
wvSetPosition -win $_nWave2 {("G3" 5)}
wvSetPosition -win $_nWave2 {("G3" 5)}
wvSetPosition -win $_nWave2 {("G3" 5)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
}
wvAddSignal -win $_nWave2 -group {"G1/reset_if(reset_io)" \
{/router_test_top/reset_if/clk} \
{/router_test_top/reset_if/reset_n} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvAddSignal -win $_nWave2 -group {"G2/router_if(router_io)" \
{/router_test_top/router_if/clk} \
{/router_test_top/router_if/frame_n\[15:0\]} \
{/router_test_top/router_if/valid_n\[15:0\]} \
{/router_test_top/router_if/din\[15:0\]} \
{/router_test_top/router_if/dout\[15:0\]} \
{/router_test_top/router_if/busy_n\[15:0\]} \
{/router_test_top/router_if/valido_n\[15:0\]} \
{/router_test_top/router_if/frameo_n\[15:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/router_test_top/host_if/clk} \
{/router_test_top/host_if/wr_n} \
{/router_test_top/host_if/rd_n} \
{/router_test_top/host_if/address\[15:0\]} \
{/router_test_top/host_if/data\[15:0\]} \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSetPosition -win $_nWave2 {("G3" 5)}
wvGetSignalClose -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G2/router_if(router_io)" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 5)}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 4)}