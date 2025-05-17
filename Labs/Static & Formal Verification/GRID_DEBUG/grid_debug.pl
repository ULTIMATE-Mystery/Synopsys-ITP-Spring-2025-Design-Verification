#!/usr/bin/perl
# Author: Christian Stangier
# Description: Perl script for debugging grid issues

use strict;
use warnings;
use Getopt::Long;
use Cwd;

my $SCRIPT_LOC =  getcwd;
my $pid = $$;
#my $SCRIPT_LOC = "/remote/us01home40/stangier/grid_debug";
my $LOG_LOC = $ENV{"HOME"};

my $EXE = "$SCRIPT_LOC/small_test";

my $workers = 1;
my $mem = 1;
my $time = 0;
my $style = "sge";
my $params;
my $help = 0 ;
my $cmd;

my $qsub = "qsub";
my $bsub = "bsub";

# usage
my $useMessage = <<"END_MESSAGE";
 usage: [--style sge|lsf][--workers <n>][--mem <n>][--log <dir>][--cmd <cmd>] --params "<parameter string>"
            --? --h --help  Prints this usage information.
            --style         Grid system to use sge/lsf (default: $style)
            --workers       Number of workers/jobs to start (default: $workers) 
            --mem           Memory in GB for each job (default: $mem, maximum: 31)
            --time          Additional time to be spent on grid cpu in secs (default: $time)
            --log           Directory for logfiles, must be present on grid machines (default: $LOG_LOC)
            --cmd           Overwrite grid submission command
            --params        Control string to be passed to sge/lsf
 note: this script works for Perl versions 5.8 and above.
END_MESSAGE

GetOptions ("style=s" => \$style,
	    "workers=i" => \$workers,
	    "mem=i" => \$mem,
	    "time=i" => \$time,
	    "log=s" => \$LOG_LOC,
	    "cmd=s" => \$cmd,
	    "params=s" => \$params,
	    'help|?|h' => \$help);


if($help || !$params){
  printf $useMessage ;
  exit(0);
}

if( ! -e "${SCRIPT_LOC}/bsub.csh"){
  printf "Grid submission script ${SCRIPT_LOC}/bsub.csh does not exist.\n";
  exit(1)
}
if( ! -e "${SCRIPT_LOC}/qsub.csh"){
  printf "Grid submission script ${SCRIPT_LOC}/qsub.csh does not exist.\n";
  exit(1)
}

if($mem < 1 || $mem > 31){
  printf "Illegal memory value of $mem GB.\n";
  exit(1)
}

if( ! -e $EXE){
  printf "Test executable $EXE does not exist.\n";
  exit(1)
}

# basic grid options checking
if ($style eq "lsf" && $params =~ /\-I/){
  printf "\nWARNING: parameters \"$params\" contain \"-I\" for interactive session and will most likely not work!\n\n";
}

# Set grid submission command
if($style eq "lsf"){
  if($cmd){
    $bsub = $cmd;
  }
  printf "Start testing submission command: $bsub $params\n";
} else {
  if($cmd){
    $qsub = $cmd;
  }
  printf "Start testing submission command: $qsub $params\n";
}

# call qsub/lsf:
for (my $w=0 ; $w < $workers; $w++) {
  my $outfile =  "$LOG_LOC/b.${pid}.${w}.out";
  if (-e $outfile) {
    `rm -f $outfile`;
  }
  if($style eq "lsf"){
    `$bsub $params -o $outfile $SCRIPT_LOC/bsub.csh $mem $EXE $time`;
  } else {
    `$qsub $params -o $outfile -v GB=$mem -v EXE=$EXE -v TIME=$time $SCRIPT_LOC/qsub.csh`;
  }
}
printf "All jobs submitted ...\n";

my $done=0;
my $success = 0;

# check workers starting, finishing and correctness
my @workerIsDone;
my @workerStarted;
my @workerSuccess;
while ( $done < $workers) {
  for (my $w=0 ; $w < $workers; $w++) {

    if (! $workerIsDone[$w]){
      my $outfile =  "$LOG_LOC/b.${pid}.${w}.out";
      if (-e $outfile) {	# check if outfile exists
	open my $vfh , "<", $outfile or die "cannot open outfile $w"  ;
	while (my $line = <$vfh>) { 	#check if outfile contains ok
	  chomp $line;
	  if (!$workerStarted[$w] && $line =~ /GridDebugStart/){
	    $workerStarted[$w] = 1;
	    printf " Worker $w started...\n";
	  }

	  if ($line =~ /Success!/){ 
	    $workerSuccess[$w] = 1;
	  }

	  if ($line =~ /GridDebugEnd/){ 
	    $workerIsDone[$w] = 1;
	    printf " Worker $w finished.\n";
	    $done++;
	    if($workerSuccess[$w]){
	      printf" Worker $w finished successfully.\n";
	      $success++;
	    } else {
	      printf" Worker $w finished with Error. Check file $LOG_LOC/b.${pid}.${w}.out for more information.\n";
	    }
	  }
	}
	close $vfh;
      }
    }
  }
  sleep 10;
}
# Summary
printf "All workers finished.\n";
if($success == $workers){
  printf "All workers  finished successfully.\n";
} else {
  printf "ERROR: Not all Workers finished successfully.\n";
}

printf "Done.\n";
