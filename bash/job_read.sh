#!/bin/sh

source ./jobber_func.sh

input="job.flow"
count=0
counter=0
while read -r line
do
  #echo "line: $line"

  if echo "${line}" | grep -q "="; then
    count=`echo "${line}" | awk -F'=' '{print $2}'`
    #echo "count: $count"
    if [ "$counter" -gt 0 ]; then
        wait
    fi

#    if [ "$count" -eq 1 ]; then
#      echo "ONE"
#    else
#      echo "MORE"
#    fi

  else
    echo "executing... job_exec ${line} &"
    job_exec ${line} &

  fi
  let "counter=counter+1"
done < "$input"

wait
