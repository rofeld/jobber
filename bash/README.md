# jobber - Resilient, Retriable, Restartable Task and Flow Framework

jobber_func.sh - functions file with the logic to retry running command on failure

env.sh - global vars setup; used in jobber_func.sh

myscript.sh - dummy script to test the functionality; it could be any script name here

ad_hoc_template.sh - example of using retry functionality in ad hoc / custom script or shell

job.flow - example of script execution control file

job_exec.sh - execution of job.flow control file

job.flow syntax rules:

the first line should be cmd=n (where n is unique number for the script)

cat job.flow

  cmd=1 # execute next line and wait for completion

  myscript.sh "ONE"

  cmd=2 # execute next line and wait for completion

  myscript.sh "TWO"

  cmd=3 # execute next two lines in parallel and wait for completion

  myscript.sh "THREE"

  myscript.sh "FOUR"

Please note: no empty lines in job.flow file.
