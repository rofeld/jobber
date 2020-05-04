# jobber

jobber_func.sh - functions file with the logic to retry running command on failure

env.sh - global vars setup; used in jobber_func.sh

myscript.sh - dummy script to test the functionality; it could be any script name here

ad_hoc_template.sh - example of using retry functionality in ad hoc / custom script or shell

job.flow - example of script execution control file

job_read.sh - execution of job.flow control file

job.flow syntax rules:

the first line should be cmd=n (where n is the number of commands to execute); 1 - in a sequence, and greater the 1 - in parallel

cat job.flow

  cmd=1 # execute next line and wait for completion

  myscript.sh "ONE"

  cmd=1 # execute next line and wait for completion

  myscript.sh "TWO"

  cmd=2 # execute next two lines in parallel and wait for completion

  myscript.sh "THREE"

  myscript.sh "FOUR"
