#!/bin/sh

source ./jobber_func.sh

job_exec myscript.sh 
status=$?

echo "STATUS: $status"
