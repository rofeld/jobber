#!/bin/sh

source ./jobber_func.sh

#execute job flow like below

job_exec myscript.sh "ONE" #run script and wait
status=$?
job_exec myscript.sh "TWO" #run script and wait
status=$?

#run scripts in parallel
job_exec myscript.sh "THREE" &
job_exec myscript.sh "FOUR" &

wait
