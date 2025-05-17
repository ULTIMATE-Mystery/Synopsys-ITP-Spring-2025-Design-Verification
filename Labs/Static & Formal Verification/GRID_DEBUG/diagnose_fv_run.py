#!/usr/bin/env python3.6

#####################################################
#
# Description:
#
#   Given a VC Formal result directory,
#   this script checks the status of the formal run.
#   - model being generated
#   - check backend qsub string - submit simple jobs 
#   - backend started
#   - some worker started
#   - all worker started
#   - some worker got killed
#
#####################################################


import os
import sys
import glob
import time
import timeit
import datetime
import argparse
import subprocess
#import subprocess
#from termcolor import colored
 
keys_to_display = ['exe-dir', 'RECIPE', 'ENGINE-DB', 'max-workers', 'max-time', 'max-mem', 'grid-type', 'grid-opt']


dict_grid_setup = { 'max-workers':None, 'grid-type':None, 'grid-opt':None }


dict_diagnosis = { }


def parse_args():
    '''
    argument parsing
    '''

    parser = argparse.ArgumentParser(
        description='Check run status via scanning FV log dir.')

    parser.add_argument(
        '--directory',
        dest='dir',
        required=False,
        help='Directory containing all .csv files need to be merged.')
    parser.set_defaults(dir='./')

    parser.add_argument(
        '-v',
        '--verbose',
        dest='verb',
        required=False,
        help='Verbosity of output log', action='store_true')
    parser.set_defaults(verbose=False)

    args = parser.parse_args()
    return args


def get_fv_dir(dir, verb):
    """
    find FV run dir
    """

    fv_run_dir = dir+'/'+'vcst_rtdb'
    if not os.path.isdir(fv_run_dir):
        print("Error: didn't find FV run dir %s" % fv_run_dir)
        return None
    print("Found FV run dir %s" % fv_run_dir)
    return fv_run_dir


def scan_cmd_line(line, verb):
    """
    display key items for launching backend
    """

    ## remove end of line
    if line[-1] == '\n':
        line = line[:-1]

    ## find key items to display
    for key in keys_to_display:
        if line.find(key+ " : ") != -1:
            print(line)
        elif line.find(key+ ":") != -1:
            print(line)

    ## store grid related to items to dictionary
    for key in dict_grid_setup.keys():
        if line.find(key+ " : ") != -1:
            str = line[line.index(':')+1:]
            dict_grid_setup[key] = str


def check_tw_log_file(tw_dir, verb):
    ## error checking
    print("-" * 80)
    tw_log_file = tw_dir+'/tw.log'
    if not os.path.isfile(tw_log_file):
        print("Error: didn't find TW manager command file %s" % tw_log_file)
        return None
    elif not os.access(tw_log_file, os.R_OK):
        print("Error: TW manager command file %s is not readable" % tw_log_file)
        return None
    else:
        print("Scanning TW manager command file %s" % tw_log_file)

    ## scan line by line
    f = open(tw_log_file, 'r')
    for line in f.readlines():
        scan_cmd_line(line, verb)

    return tw_log_file


def show_general_env():
    """
    display general env, eg. shell, host, library
    """

    print("-" * 80)
    print("USER: %s " % os.getlogin())
    print("HOST: %s " % os.uname()[1])
    print("CWD: %s " % os.getcwd())
    print("LD_LIBRARY_PATH: %s" % os.getenv('LD_LIBRARY_PATH', default='NOT_SET_YET'))
    # print("PY_EXE: %s" % sys.executable
    # print("PID: %s " % str(os.getpid())


def testing_system_command(cmd):
   """
   testing system command
   """

   status, output = os_system_w_return(cmd)
   if str(status) == '0':
       print("Testing command: %s -> succeeded" % cmd)
   else:
       print("Testing command: %s -> failed" % cmd)
   return status


def test_grid_env():
    """
    test general grid env for SGE and LSF 
    """

    username = os.getlogin()

    if dict_grid_setup['grid-type'] == 'SGE':
        print("-" * 80)
        print("Grid testing via SGE commands (eg. qsub):")
        ret = testing_system_command('which qsub')
        if ret != 0:
            dict_diagnosis['grid submission'] = [ 'Error', 'not qsub in current environment' ]
        else:
            ret = testing_system_command('which qdel')
            if ret != 0:
                dict_diagnosis['grid submission'] = [ 'Error', 'not qdel in current environment' ]
            else:
                cmd = 'qhost -q ; qstat -u '+username
                testing_system_command(cmd)

    if dict_grid_setup['grid-type'] == 'LSF':
        print("-" * 80)
        print("Grid testing via LSF commands (eg. bsub):")
        ret = testing_system_command('which bsub')
        if ret != 0:
            dict_diagnosis['grid submission'] = [ 'Error', 'not bsub in current environment' ]
        else:
            ret = testing_system_command('which bkill')
            if ret != 0:
                dict_diagnosis['grid submission'] = [ 'Error', 'not bkill in current environment' ]
            else:
                cmd = 'bqueues ; bjobs -u '+username
                testing_system_command(cmd)


def check_dir(caption, dir, verb):
    """
    check if dir exists
    """

    if not os.path.isdir(dir):
        print("Error: didn't %s dir %s" % (caption, dir))
        return False
    else:
        print("Scanning %s dir %s" % (caption, dir))
        return True


def os_system_w_return(cmd):
    """
    run system command and collect return
    """

    status, output = subprocess.getstatusoutput(cmd)
    return status, output


def check_cdpl_dir(cdpl_dir, verb):
    """
    check cdpl dir
    """

    pattern = cdpl_dir+'/master*'
    cdpl_master_logs = glob.glob(pattern)
    print("Found %d CDPL master log(s)" % len(cdpl_master_logs))

    pattern = cdpl_dir+'/worker*'
    cdpl_worker_logs = glob.glob(pattern)
    print("Found %d CDPL worker log(s)" % len(cdpl_worker_logs))

    ## cdpl master log
    pattern = cdpl_dir+'/master*log'
    cdpl_master_log = glob.glob(pattern)
    if len(cdpl_master_log) >= 1:
        print("Scanning CDPL master main log %s" % cdpl_master_log[0])
        if verb:
            os.system('egrep -e \"_worker|cdpl_server_sched|cdpl_farm\" '+cdpl_master_log[0])
        else:
            #os.system('grep _worker '+cdpl_master_log[0])
            status, num_worker_started = os_system_w_return('grep "started worker" '+cdpl_master_log[0]+' | wc -l')
            status, num_worker_stopped = os_system_w_return('grep "freeing worker" '+cdpl_master_log[0]+' | wc -l')
            print("%s worker(s) started and %s worker(s) stopped." % (num_worker_started, num_worker_stopped))

    ## cdpl master error file
    pattern = cdpl_dir+'/master*err'
    cdpl_master_err = glob.glob(pattern)
    if len(cdpl_master_err) >= 1:
        print("Scanning CDPL master error log %s" % cdpl_master_err[0])
        if os.stat(cdpl_master_err[0]).st_size == 0:
            print("No error.")
        else:
            print("Found reported error(s):")
            os.system('cat '+cdpl_master_err[0])
            caption = 'Submission failure reported in %s' % cdpl_master_err[0]
            dict_diagnosis['grid submission'] = [ 'Error!', caption ]

    if verb:
        for worker_log in cdpl_worker_logs:
            print("-" * 80)
            print("Scanning CDPL worker log (%d/%d) %s" % (cdpl_worker_logs.index(worker_log)+1, len(cdpl_worker_logs), worker_log))
            #os.system('egrep -e \"task|RELAY\" '+worker_log)
            os.system('grep task '+worker_log)


def show_list_upto(list, limit):
    if len(list) <= limit:
        print("  {0}".format(list))
    else:
        print("  {0} ... ({1} in total)".format(list[:limit], len(list)))


def report_matching_logs(dir, pattern, caption, verb):
    """
    report set of log matching the given pattern
    default, report number of logs
    verbose, list log file names 
    """

    logs = glob.glob(pattern)
    if not verb:
        print("Found %d %s(s)" % (len(logs), caption))
    else:
        print("Found %d %s(s) under %s" % (len(logs), caption, dir))
        for log in logs:
            print("  %s" % log[log.rfind('/')+1:])
    return len(logs)


def check_tw_vp_dir(vp_dir, verb):
    """
    check vp dir
    """

    pattern = vp_dir+'/*dfg*'
    ctr_dfg = report_matching_logs(vp_dir, pattern, "TW DFG", verb)

    pattern = vp_dir+'/*saig*'
    ctr_saig = report_matching_logs(vp_dir, pattern, "TW SAIG", verb)

    if not ctr_dfg+ctr_saig > 0:
        dict_diagnosis['verification problem'] = [ 'Error', 'no model being generated' ]
    else:
        caption = '%d DFG %d SAIG model(s) being generated' % (ctr_dfg, ctr_saig) 
        dict_diagnosis['verification problem'] = [ 'Good', caption ]


def check_tw_slave_dir(tw_slave_dir, verb):
    """
    check tw slave log dir
    """

    pattern = tw_slave_dir+'/log.*'
    eng_log_dirs = glob.glob(pattern)
    print("Found %d TW engine log dir(s)" % len(eng_log_dirs))
    num_of_task = 0
    for eng_log_dir in eng_log_dirs:
        #task_dirs = os.listdir(eng_log_dir)
        pattern = eng_log_dir+'/vTsk*.dir'
        task_dirs = glob.glob(pattern)
        num_of_task += len(task_dirs)
        if verb:
            #print("Dir %s contain %d task dir(s)" % (eng_log_dir[eng_log_dir.rfind('/')+1:], len(task_dirs))
            print("Found %d task dir(s) under %s" % (len(task_dirs), eng_log_dir))
            show_list_upto(task_dirs, 5)
    if not num_of_task > 0:
        print("No task dir found. Error!")
        dict_diagnosis['backend task'] = [ 'Error', 'no task was ran' ]
    else:
        print("Found %d task dir(s) totally" % num_of_task)
        caption = '%d task(s) ran' % num_of_task
        dict_diagnosis['backend task'] = [ 'Good', caption ]

    pattern = tw_slave_dir+'/tw_slave*main*'
    ctr = report_matching_logs(tw_slave_dir, pattern, "TW slave main thread log", verb)
    if not ctr > 0:
        dict_diagnosis['worker status'] = [ 'Error', 'no worker' ]
    elif ctr != int (dict_grid_setup['max-workers']):
        caption = 'only {0}/{1} worker(s) launched'.format(ctr, dict_grid_setup['max-workers'])
        dict_diagnosis['worker status'] = [ 'OK', caption ]
    else:
        caption = 'all {0}/{1} worker(s)'.format(ctr, dict_grid_setup['max-workers'])
        dict_diagnosis['worker status'] = [ 'Good', caption ]

    pattern = tw_slave_dir+'/tw_slave*monitor*'
    ctr = report_matching_logs(tw_slave_dir, pattern, "TW slave monitor thread log", verb)
 

def check_tw_dir(fv_run_dir, verb):
    """
    scan tw run dir
    """

    print("-" * 80)
    pattern = fv_run_dir+'/.internal/formal/fpId0/tw*'
    tw_run_dirs = glob.glob(pattern)
    print("Found %d dir via globbing \'%s\'." % (len(tw_run_dirs), pattern))

    if not len(tw_run_dirs) > 0:
        dict_diagnosis['backend run dir'] = [ 'Error', 'not found' ]
        return None

    ## ==========================
    ## for each tw dir
    # for tw_dir in tw_run_dirs:
    ## ==========================
    ## check one tw dir for now
    tw_dir = tw_run_dirs[0]
    ## ==========================

    if not check_dir("TW run", tw_dir, verb):
        dict_diagnosis['backend run'] = [ 'Error', 'not happened' ]

    check_tw_log_file(tw_dir, verb)

    ## tw model dir
    print("-" * 80)
    vp_dir = tw_dir+'/run_tw_session/vp0'
    if not check_dir("TW VP", vp_dir, verb):
        dict_diagnosis['backend verification problem dir'] = [ 'Error', 'not generated' ]
    else:
        check_tw_vp_dir(vp_dir, verb)

    ## cdpl dir
    print("-" * 80)
    cdpl_dir = tw_dir+'/run_tw_session/log.cdpl'
    if not check_dir("CDPL run", cdpl_dir, verb):
        dict_diagnosis['backend distributed run'] = [ 'Error', 'not happened' ]
    else:
        check_cdpl_dir(cdpl_dir, verb) 

    ## tw slave dir
    print("-" * 80)
    tw_slave_dir = tw_dir+'/run_tw_session/log.tw-slave'
    if not check_dir("TW slave run", tw_slave_dir, verb):
        dict_diagnosis['backend engine run'] = [ 'Error', 'not happened' ]
    else:
        check_tw_slave_dir(tw_slave_dir, verb) 

    return tw_run_dirs


def validate_grid_setup(verb):
    """
    try grid submission for SGE/LSF
    """

    ## setup grid testing
    small_test = os.getenv('VC_STATIC_HOME')+'/doc/vcst/examples/GRID_DEBUG/small_test'
    if not (os.path.isfile(small_test) and os.access(small_test, os.X_OK)):
        print("Error: cannot find small_test %s" % small_test)
        return

    #print("Grid setup: {0}".format(dict_grid_setup))
    mem = 4 ## memory in gb
    time = 60 ## time in sec
    out_log = 'fv_grid_submission_test.log'
    err_log = 'fv_grid_submission_test.err'
    if os.path.isfile(out_log): os.remove(out_log)
    if os.path.isfile(err_log): os.remove(err_log)
    print("If you still cannot run FV on grid, please proceed with the following.")
    print("(1) test grid submission using the following command which will submit a 1-minute job to farm consuming 4GB")
    username = os.getlogin()

    ## try SGE
    if dict_grid_setup['grid-type'] == 'SGE':
        qsub_csh = os.getenv('VC_STATIC_HOME')+'/doc/vcst/examples/GRID_DEBUG/qsub.csh'
        if not (os.path.isfile(qsub_csh) and os.access(qsub_csh, os.X_OK)):
            print("Error: cannot find qsub_csh %s" % qsub_csh)
            return
        #`$qsub $params -o $outfile -v GB=$mem -v EXE=$EXE -v TIME=$time $SCRIPT_LOC/qsub.csh`;
        cmd = '%s -o %s -e %s -v GB=%d -v EXE=%s -v TIME=%d %s' % (dict_grid_setup['grid-opt'], out_log, err_log, mem, small_test, time, qsub_csh)
        print
        print(cmd)
        print
        print("(2) monitor running jobs: qstat -u %s" % username)
        print("(3) debug completed jobs: qacct -j <job_id>")
        print("(4) check-out cluster status: qhost -q")

    ## try LSF:
    if dict_grid_setup['grid-type'] == 'LSF':
        bsub_csh = os.getenv('VC_STATIC_HOME')+'/doc/vcst/examples/GRID_DEBUG/bsub.csh'
        if not (os.path.isfile(bsub_csh) and os.access(bsub_csh, os.X_OK)):
            print("Error: cannot find bsub_csh %s" % bsub_csh)
            return
        #`$bsub $params -o $outfile $SCRIPT_LOC/bsub.csh $mem $EXE $time`;
        cmd = '%s -o %s -e %s %s %d %s %d' % (dict_grid_setup['grid-opt'], out_log, err_log, bsub_csh, mem, small_test, time)
        print
        print(cmd)
        print
        print("(2) monitor running jobs: bjobs -u %s" % username)
        print("(3) debug completed jobs: bjobs -N <job_id>")
        print("(4) check-out cluster status: bqueues")
    
    print("(5) study stdout log: %s created at your home directory" % (out_log))
    print("          stderr log: %s created at your home directory" % (err_log))
    print
    print("Please always use the following suite to pipe-clean grid setup before applying it to the tool!")
    print("%s/%s" % (os.getenv('VC_STATIC_HOME'), '/doc/vcst/examples/GRID_DEBUG'))
    print

def main(argv):

    print("-" * 80)
    start_time = timeit.default_timer()
    print("Grid Setup Diagnosing Script START ...", time.strftime("%c"))

    ## show general env
    show_general_env()

    args = parse_args()
    dname = args.dir
    verb = args.verb

    ## search FV run dir
    fv_run_dir = get_fv_dir(args.dir, args.verb)

    ## test SGE and LSF general commands
    test_grid_env()

    ## scan tw run dir
    tw_run_dirs = check_tw_dir(fv_run_dir, args.verb)

    ## final report
    print("-" * 80)
    print
    print("[ Final report ]")
    print
    for key, val in dict_diagnosis.items():
        if val[0] == 'Error':
            print("\x1b[6;30;41m%6s\x1b[0m! %s: %s" % (val[0], key, val[1]))
        else:
            print("\x1b[6;30;42m%6s\x1b[0m! %s: %s" % (val[0], key, val[1]))

    ## try grid submission for SGE/LSF
    print
    validate_grid_setup(args.verb)

    print("-" * 80)
    elapsed = timeit.default_timer() - start_time
    sys.stdout.write("Grid Setup Diagnosing Script DONE in %.1f sec. " % elapsed)
    print(time.strftime("%c"))
    print("-" * 80)

if __name__ == "__main__":
    sys.exit(main(sys.argv))
