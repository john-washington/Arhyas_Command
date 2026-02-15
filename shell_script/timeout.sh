#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

host="$1"
code="$2"

OS_NAME=$(uname -s)

case "$OS_NAME" in
	Linux*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo apt install traceroute; }
		;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		;;
	*)
		;;
esac

#Aborting."; exit 1; }

PATH=$PATH:/opt/local/bin:/usr/bin
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
