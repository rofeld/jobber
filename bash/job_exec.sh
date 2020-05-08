#!/bin/sh

source ./jobber_func.sh

input="job.flow"
count=0
counter=0
current_file=`basename "$0"`
current_file="${current_file}_tmp"
restart=""

cp "${input}" "${input}_tmp"
input_tmp="${input}_tmp"


if [ -e ${current_file} ]; then
  restart=`cat ${current_file}`
  sed -n '/'"${restart}"'/,$p' "${input_tmp}" > "${input_tmp}2"
  mv "${input_tmp}2" "${input_tmp}"
fi

WAIT_ERROR=0

while read -r line && [[ "$WAIT_ERROR" -eq 0 ]]
do
  #echo "line: $line"

  if echo "${line}" | grep -q "cmd="; then
    #count=`echo "${line}" | awk -F'=' '{print $2}'`
    #echo "count: $count"
    count=0
    if [ "$counter" -gt 0 ]; then
      for pid in ${pids[*]}; do
        wait $pid || let "WAIT_ERROR+=1"
      done
    fi

    unset pids

    if [ "$WAIT_ERROR" -gt 0 ]; then
      break
    fi

    label=${line}
    echo "${label}" > ${current_file}

#    if [ "$count" -eq 1 ]; then
#      echo "ONE"
#    else
#      echo "MORE"
#    fi

  else
    if [ "$WAIT_ERROR" -gt 0 ]; then
      break
    fi
    echo "executing... job_exec ${line} &"
      let "count+=1"
      job_exec ${line} &
      pids[${count}]=$!

  fi
  let "counter=counter+1"

  if [ "$WAIT_ERROR" -gt 0 ]; then
    break
  fi
done < "$input_tmp"

if [ "$WAIT_ERROR" -gt 0 ]; then
  exit 1
else
  for pid in ${pids[*]}; do
      wait $pid || let "WAIT_ERROR+=1"
  done
  if [ "$WAIT_ERROR" -gt 0 ]; then
    exit 1
  else
    rm -if ${current_file}
  fi
fi
