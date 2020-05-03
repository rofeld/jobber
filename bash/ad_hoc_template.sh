#!/bin/sh

source ./jobber_func.sh

#execute job flow like below

job_exec myscript.sh "ONE" #run script and wait
status=$?
job_exec myscript.sh "TWO" #run script and wait
status=$?

#run scripts in parallel; need to handle exit status yourself
job_exec myscript.sh "THREE" &
job_exec myscript.sh "FOUR" &
wait

#run scripts in parallel; script will exit in case of error
set -e
job_exec2 myscript.sh "FIVE" &
job_exec2 myscript.sh "SIX" &
wait
