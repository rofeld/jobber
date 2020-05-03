#!/bin/sh

source ./jobber_func.sh

job_exec myscript.sh "ONE"
status=$?
job_exec myscript.sh "TWO"
status=$?

job_exec myscript.sh "THREE" &
job_exec myscript.sh "FOUR" &

wait


echo "STATUS: $status"

#echo "ARGs: $@"
