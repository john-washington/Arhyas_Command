#!/bin/bash
host="$1"
code="$2"

#command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). Aborting."; exit 1; }
PATH=$PATH:/opt/local/bin
export PATH

timeout 15 ping -c 6 $host

status=$?
if [ $status -eq 124 ]; then
	echo "$1 is probably unpingable...";
	traceroute  $host |  bash ./tracelist.sh $code  | xargs -n 2 bash  ./arhyas_msg.sh 
elif [ $status -ne 0 ]; then
	echo "command failed with status: $status";
	traceroute  $host |  bash ./tracelist.sh $code  | xargs -n 2 bash ./arhyas_msg.sh 
else
	bash ./arhyas_msg.sh $host $code  
fi