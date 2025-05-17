#!/bin/csh
# Author: Christian Stangier
# Date: March 2016
# Description: csh script for debugging grid issues

echo GridDebugStart
date 
hostname
echo $EXE
$EXE $GB $TIME &
wait
date
echo GridDebugEnd
