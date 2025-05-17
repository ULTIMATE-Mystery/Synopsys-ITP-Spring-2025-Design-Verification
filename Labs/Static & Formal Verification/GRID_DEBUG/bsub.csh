#!/bin/csh
# Author: Christian Stangier
# Date: March 2016
# Description: csh script for debugging grid issues

# param 1 = mem param 2 = test executable param 3 = extraTime
echo GridDebugStart
date 
hostname
$2 $1 $3 &
wait
date
echo GridDebugEnd
