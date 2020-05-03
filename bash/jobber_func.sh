#!/bin/sh

source ./env.sh

function job_call
{
  local status=1
  local count=0

  while [ "$status" -ne 0 ];
    do
        echo "job call ARGs: $@"
        sh "$@"
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
  echo "job exec ARGs: $@"
  local status=0
  local COUNTER=0
  job_call "$@" &
  local jobber_pid=$!
  wait $jobber_pid || let "COUNTER+=1"
  status=$COUNTER
  return $status
}

function job_exec2
{
  local status=0
  job_exec "$@"
  status=$?

  if [ "$status" -ne 0 ]; then
    exit 1
  fi

}
