#!/bin/csh -f
setenv VCS_HOME /home/shtp/ShareData/0-Server/2-Lab/Tools/vc_static/R-2020.12-SP2-13/vcs-mx
setenv VC_STATIC_HOME /home/shtp/ShareData/0-Server/2-Lab/Tools/vc_static/R-2020.12-SP2-13
setenv SYNOPSYS_SIM_SETUP /home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/synopsys_sim.setup

$VCS_HOME/bin/vcs /home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/undef_vcs.v -file /home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/.internal/design/vcsCmd +warn=noSM_CCE  -kdb=common_elab  -Xufe=parallel:incrdump  +warn=noKDB-ELAB-E  +warn=noELW_UNBOUND  -Xverdi_elab_opts=-saveLevel  -verdi_opts "-logdir /home/shtp/ITP2025/Labs/FPV/FPV/run/vcst_rtdb/verdi/elabcomLog " -Xvd_opts=-silent,-ssy,-ssv,-ssz,+disable_message+C00373, -full64
