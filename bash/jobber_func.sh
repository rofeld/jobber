#!/bin/sh

source ./env.sh

function job_call
{
  local status=1
  local count=0

  local script=$1

  while [ "$status" -ne 0 ];
    do
        sh $script
        status=$?
        if [ "$status" -eq 0 ]; then
          break
        fi

        count=$(($count + 1))
        echo "LOOP COUNTER: $count"
        if [ $count -lt $MAX_RETRIES ]; then
          sleep $(($count*$INTERVAL))
        else
          break
        fi
    done

    return $status
}

function job_exec
{
  local status=0
  local script=$1
  local COUNTER=0
  job_call $script &
  local jobber_pid=$!
  wait $jobber_pid || let "COUNTER+=1"
  status=$COUNTER
  return $status
}
