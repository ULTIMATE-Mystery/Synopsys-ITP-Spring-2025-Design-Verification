verdiWindowWorkMode -win $_Verdi_1 -formalVerification
verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
srcSetPreference -vcstOpts \
           {-demo -file run.tcl -prompt vcf -fmode _default -new_verdi_comm}
verdiWindowResize -win $_Verdi_1 "0" "0" "1252" "839"
schSetVCSTDelimiter -hierDelim "."
srcSetXpropOption "tmerge"
wvSetPreference -overwrite off
wvSetPreference -getAllSignal off
simSetSimulator "-vcssv" -exec \
           "/home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/simv" \
           -args
debImport "-simflow" "-smart_load_kdb" "-dbdir" \
          "/home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/simv.daidir" \
          -autoalias
srcSetPreference -tabNum 16
srcSetSnipSignal -reset
opVerdiComponents -xmlstr \
           "<Command delimiter=\"/\" name=\"schSession\">
<HighlightObjs clear=\"true\"/>
</Command>
"
opVerdiComponents -xmlstr \
           "<Command delimiter=\"/\" name=\"schSession\">
<HighlightObjs clear=\"true\"/>
</Command>
"
verdiVcstEditTclPrjFile
srcSaveAs -win $_nTrace3 -file run.tcl
verdiWindowSaveUserLayout -win $_Verdi_1 "UserRestart_1"
verdiVcstRestartShellApp
verdiWindowRestoreUserLayout -win $_Verdi_1 "UserRestart_1"
verdiWindowResize -win $_Verdi_1 "0" "0" "1252" "839"
schSetVCSTDelimiter -hierDelim "."
srcSetXpropOption "tmerge"
wvSetPreference -overwrite off
wvSetPreference -getAllSignal off
simSetSimulator "-vcssv" -exec \
           "/home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/simv" \
           -args
debImport "-simflow" "-smart_load_kdb" "-dbdir" \
          "/home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/simv.daidir" \
          -autoalias
srcSetPreference -tabNum 16
srcSetSnipSignal -reset
debLoadUserDefinedFile \
           /home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/verdi/constant.uddb
verdiDockWidgetDisplay -dock widgetDock_VCF:ComplexityReport
vcstPropertyDensity -select {Design: traffic}
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
verdiDockWidgetDisplay -dock widgetDock_VCF:ComplexityReport
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_VCF:TaskList
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
verdiDockWidgetSetCurTab -dock widgetDock_<Message>
verdiDockWidgetSetCurTab -dock windowDock_vcstConsole_2
verdiDockWidgetSetCurTab -dock widgetDock_VCF:ComplexityReport
verdiDockWidgetSetCurTab -dock widgetDock_VCF:PropertyDensity
verdiRunVcstCmd check_fv

verdiDockWidgetSetCurTab -dock windowDock_vcstConsole_2
verdiRunVcstCmd check_fv

verdiVcstEditTclPrjFile
verdiDockWidgetHide -dock widgetDock_VCF:ComplexityReport
verdiDockWidgetHide -dock widgetDock_VCF:PropertyDensity
verdiWindowSaveUserLayout -win $_Verdi_1 "UserRestart_1"
verdiVcstRestartShellApp
verdiWindowRestoreUserLayout -win $_Verdi_1 "UserRestart_1"
verdiWindowResize -win $_Verdi_1 "0" "0" "1252" "839"
schSetVCSTDelimiter -hierDelim "."
srcSetXpropOption "tmerge"
wvSetPreference -overwrite off
wvSetPreference -getAllSignal off
simSetSimulator "-vcssv" -exec \
           "/home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/simv" \
           -args
debImport "-simflow" "-smart_load_kdb" "-dbdir" \
          "/home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/simv.daidir" \
          -autoalias
srcSetPreference -tabNum 16
srcSetSnipSignal -reset
debLoadUserDefinedFile \
           /home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/verdiconstant.uddb
verdiDockWidgetDisplay -dock widgetDock_VCF:ComplexityReport
verdiRunVcstCmd check_fv

verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_VCF:TaskList
verdiDockWidgetSetCurTab -dock windowDock_vcstConsole_2
debExit
