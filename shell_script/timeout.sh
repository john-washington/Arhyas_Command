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
		command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo apt install curl; }
    	data_dir=../txt
    	TEMP_DIR=~/Documents/Arhyas_Command
      	APP_RES_DIR=~/Arhyas_Command
		;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo port install curl; }
    	data_dir="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
    	TEMP_DIR=~/Documents/Arhyas_Command
        APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
     
		;;
	*)
		;;
esac

#Aborting."; exit 1; }

PATH=$PATH:/opt/local/bin:/usr/bin
export PATH

found=$(find "${data_dir}" -type f -name "${host}_trace_result.txt" )

if [[ -z $found ]]; then
	traceroute  $host |  bash ./tracelist.sh > "${data_dir}/${host}_trace_result.txt"
else
	echo "${data_dir}/${host}_trace_result.txt already exist" | tee -a "${APP_RES_DIR}/arhyas_command.log"
fi

found1=$(find "${data_dir}" -type f -name "${host}_trace_result.txt_geo_data.csv" ) 

if [[ -z $found1 ]]; then
	bash ./ip-api.sh -b "${data_dir}/${host}_trace_result.txt" | tee -a "${APP_RES_DIR}/arhyas_command.log"

else
	echo "${data_dir}/${host}_trace_result.txt_geo_data.csv already exist" | tee -a "${APP_RES_DIR}/arhyas_command.log"
fi

timeout 15 ping -c 6 $host
status=$?
if [ $status -eq 124 ]; then
	echo "$1 is probably unpingable...";
	cat "${data_dir}/${host}_trace_result.txt" $code  | xargs -n 2 bash  ./arhyas_msg.sh 
elif [ $status -ne 0 ]; then
	echo "command failed with status: $status";
	cat "${data_dir}/${host}_trace_result.txt" $code  | xargs -n 2 bash ./arhyas_msg.sh 
else
	bash ./arhyas_msg.sh $host $code  
fi



