#!/bin/csh -f

if (-d csrc) then
rm -rf csrc
endif
if (-d simv.daidir) then
rm -rf simv*
endif

echo "############################################################################"
echo "      Flow: Run Simulation with Coverage instumentation "
echo ""

sleep 2

echo "############################################################################"
echo "      Compile and elaborate the design and testbench with coverage enabled "
echo ""

vcs -full64 -sverilog -f ../design/sim_filelist -debug_acc+all -cm line+cond+tgl

sleep 2
echo "############################################################################"
echo "      Run simulation with Coverage enabled"
echo ""
./simv  -cm line+cond+tgl


sleep 2
echo "############################################################################"
echo "      URG(unified report generator) command to generate coverage results. Reports are available in the directory sim_alone in text format"
echo ""
urg -dir simv.vdb/ -report sim_alone -format text

##Execute verdi command to see the Coverage results
#$verdi -cov -covdir simv.vdb

