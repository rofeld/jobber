#!/bin/sh

source ./jobber_func.sh

job_exec myscript.sh "ONE" "TWO"
status=$?

echo "STATUS: $status"

#echo "ARGs: $@"
