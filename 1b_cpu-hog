#!/bin/bash
# Script that monitors the top-active process. The script sends an email to the user root if
# utilization of the top active process goed beyond 80%. Of course, this script can be tuned to 
# do anything else in such a case.
#
# Start the script, and it will run forever.
 
declare -a PROC
topProcess() {
	local OUT=$(ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1)
	local USAGE=$(echo $OUT | awk '{print $1}')
	USAGE=${USAGE%.*}
	local PID=$(echo $OUT | awk '{print $2 }')
	local PNAME=$(echo $OUT | awk '{$1=$2=""; print $0; }')
	PROC=(${USAGE} ${PID} ${PNAME})
}
 
while true
do
	# Check every 60 seconds if we have a process causing high CPU load
	#sleep 60
	sleep 1
	topProcess
 
	# Only if we have a high CPU load on one process, run a check within 7 seconds
	# In this check, we should monitor if the process is still that active
	# If that's the case, root gets a message
	if [ ${PROC[0]} -gt 80 ] 
	then
		PROC1=PROC
		sleep 7
		topProcess
 
		# Now we have variables with the old process information and with the
		# new information
 
		[ ${PROC[0]} -gt 80 ] && [ ${PROC[1]} = ${PROC1[1]} ] && mail -s "CPU load of ${PROC[2]} is above 80%" root@blah.com < .
	fi
done
