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
		data_dir=../data
		txt_dir=../txt
		log_dir=../log
		TEMP_DIR=~/Documents/Arhyas_Command
		APP_RES_DIR=~/Arhyas_Command
		;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo port install curl; }
		APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
		data_dir="${APP_RES_DIR}/data"
		txt_dir="${APP_RES_DIR}"
		log_dir="${APP_RES_DIR}/log"
		TEMP_DIR=~/Documents/Arhyas_Command
     
		;;
	*)
		;;
esac

#Aborting."; exit 1; }

PATH=$PATH:/opt/local/bin:/usr/bin
export PATH

mkdir -p "${log_dir}"
mkdir -p "${data_dir}"

found=$(find "${data_dir}" -type f -name "${host}_trace_result.txt" )

#if [[ -s  "${data_dir}/${host}_trace_result.txt" ]]; then
if [[ $(wc -c < "$found" ) -eq 0 ]]; then
	traceroute  $host |  bash ./tracelist.sh > "${data_dir}/${host}_trace_result.txt"
else
	echo "${data_dir}/${host}_trace_result.txt already exist and not empty" | tee -a "${log_dir}/arhyas_command.log"
fi

found1=$(find "${data_dir}" -type f -name "${host}_trace_result.txt_geo_data.json" ) 

#if [ -f  "${data_dir}/${host}_trace_result.txt_geo_data.csv" ] && [ $(wc -c < "${data_dir}/${host}_trace_result.txt_geo_data.json") -gt 2]; then
if [[ $(wc -c < "$found1" ) -eq 0  ||  $(wc -c < "${data_dir}/${host}_trace_result.txt_geo_data.json" ) -le 2 ]]; then
	bash ./ip-api.sh -b "${data_dir}/${host}_trace_result.txt" | tee -a "${log_dir}/arhyas_command.log"
else
	echo "${data_dir}/${host}_trace_result.txt_geo_data.json already exist and not empty" | tee -a "${log_dir}/arhyas_command.log"
fi

timeout 15 ping -c 6 $host
status=$?
if [ $status -eq 124 ]; then
	echo "$1 is probably unpingable...";
	cat "${data_dir}/${host}_trace_result.txt" |  bash ./append_code.sh  "$code" |  xargs -n 2 bash  ./arhyas_msg.sh 
	
elif [ $status -ne 0 ]; then
	echo "command failed with status: $status";
	cat "${data_dir}/${host}_trace_result.txt" |  bash ./append_code.sh  "$code" |  xargs -n 2 bash  ./arhyas_msg.sh 
	
else
	bash ./arhyas_msg.sh "$host" "$code"  
fi



