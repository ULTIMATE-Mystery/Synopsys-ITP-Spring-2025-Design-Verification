To test grid setup
==================

Script diagnose_fv_run.py provides testing capabilities for grid setup.

  1. Run $VC_STATIC_HOME/auxx/mlplatform/bin/py_exec diagnose_fv_run.py --directory <path to directory where vcst_rtdb is present> [--verbose]
     Optionally, use Python directly to run script diagnose_fv_run.py. 
     If not installed, use the one in the VC Formal installation by setting the following environment variables to set up the Python environment:
	setenv PYTHONHOME $VC_STATIC_HOME/auxx/yoda/python
	setenv PATH $PYTHONHOME/bin:$PATH
	setenv LD_LIBRARY_PATH $PYTHONHOME/lib:$LD_LIBRARY_PATH

  2. Check output of the above command (look for "Final report" section) and log files $HOME/fv_grid_submission_test.log $HOME/fv_grid_submission_test.err.

  3. Please note that the above script will work only when you have used either 'check_fv -traceLevel 1' or 'set_fml_var fml_cleanup_on_exit false' in your testcase.


To debug grid issues
====================

Script grid_debug.pl provides debugging capabilities for grid setup.
It works standalone without a VC_Formal installation and does not require a license.

 usage: [--style qsub|lsf][--workers <n>][--mem <n>][--log <dir>][--cmd <cmd>] --params "<parameter string>"
            --? --h --help  Prints this usage information.
            --style         Grid system to use qsub/lsf (default: qsub)
            --workers       Number of workers/jobs to start (default: 1, maximum: 31)
            --mem           Memory in GB for each job (default: 1)
            --time          Additional time to be spent on grid cpu in secs (default: 0)
            --log           Directory for logfiles, must be present on grid machines (default: /remote/us01home40/stangier)
            --cmd           Overwrite grid submission command
            --params        Control string to be passed to qsub/lsf

The script works for Perl versions 5.8 and above.

Examples:

Basic test for qsub, 2 jobs, 2GB each:
grid_debug.pl --workers 2 --mem 2 --params "-P bnormal -V -l arch=glinux,mem_free=1G " 

Basic test for lsf, 4 jobs, 8GB each:
grid_debug.pl --style lsf --workers 4 --mem 8 --time 60 --params '-q bnormal -I -R "rusage[mem=1000]" '

Test for qsub, 2 jobs, 2GB each, compute at least 1800s:
grid_debug.pl --workers 2 --mem 2 --time 1800 --params "-P bnormal -V -l arch=glinux,mem_free=1G " 

Basic test for lsf, 4 jobs, 8GB each, use a different log directory:
grid_debug.pl --style lsf --workers 4 --mem 8 --log /u/bob --params '-q bnormal -I -R "rusage[mem=1000]" '

Test for qsub, 2 jobs, 2GB each, use a different grid command:
grid_debug.pl --workers 2 --mem 2 --cmd /installs/our_qsub/qsub --params "-P bnormal -V -l arch=glinux,mem_free=1G " 

Please check section "Running on Compute Farm" of the VC Formal User Guide for more details.
============================================================================================
