#!/bin/csh -f

#setenv SNPS_VCF_NEW_FML_CORE_COV 1

echo "############################################################################"
echo "      Run Formal Property verification followed by Formal Core Coverage analysis "
echo " "

vcf -batch -f run.tcl

echo "############################################################################"
echo "      Run urg to merge formal core coverage with simulation coverage results"
echo " "

urg -dir simv.vdb/ -dir formal_core_cov.vdb -map traffic -report merge -format text  -dbname Merge_db

echo "############################################################################"
echo "      Do gvim -d sim_alone/hierarchy.txt merge/hierarchy.txt to see the difference in Coverage results "

