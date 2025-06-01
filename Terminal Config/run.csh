#!/bin/csh
module load vcs/2024.09-SP1-1 verdi/2024.09-SP1-1 spyglass/2024.09-SP1-1 vcstatic/2022.06-SP2-3 syn/2024.09-SP2
setenv FSDB_SVA_SUCCESS 1  
bsub -app shared-0002 xterm