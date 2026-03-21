#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
    command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout;}
   
    APP_RES_DIR=~/Arhyas_Command
    data_dir=../data
    text_dir=../txt
    log_dir=../log
    ;;
  Darwin*)
    command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout;}
   
    APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
    data_dir="${APP_RES_DIR}/data"
    text_dir="${APP_RES_DIR}"
    log_dir="${APP_RES_DIR}/log"
    ;;
  *)
    ;;
esac

PATH=$PATH:/opt/local/bin:/usr/bin
export PATH

csv_file="$1"
host="$2"
 
mkdir -p "${log_dir}"

str_to_hex() {
    printf '%s' "$1" | od -An -t x1 | tr -d ' \n'
}

split_send_sp() {
  IFS=' '
  wc_byte=$( echo "$2" | wc -c )
    echo "byte count: $wc_byte" 

    if [[ $wc_byte -le 16 ]]; then
      ping -c 6 -p "$1" $host | tee -a "${log_dir}/error.log"
    else
      
      read -r -a hex_arry <<< "$2" 
      
      for part in "${hex_arry[@]}"; do
        echo "part: $part" | tee -a "${log_dir}/arhyas_command.log"
      
        my_hex_string=$(str_to_hex "$part")

        wc_byte2=$( echo "$part" | wc -c )
        echo "byte count2: $wc_byte2" | tee -a "${log_dir}/arhyas_command.log"

        if [[ $wc_byte2 -le 16 ]]; then
          ping -c 6 -p "$my_hex_string" $host | tee -a "${log_dir}/arhyas_command.log"
        else
           echo "warning: $part encoded to $my_hex_string is too long for transmission, try sending anyway..." | tee -a "${log_dir}/error.log"
           ping -c 6 -p "$my_hex_string" $host | tee -a "${log_dir}/error.log"
           #r=$(split_send_hp "$my_hex_string" "$part")
        fi
      done

    fi
    IFS=$' \t\n'
}


split_send_hp() {
  IFS='-'
  wc_byte=$( echo "$2" | wc -c )
    echo "byte count: $wc_byte" 

    if [[ $wc_byte -le 16 ]]; then
      ping -c 6 -p "$1" $host | tee -a "${log_dir}/arhyas_command.log"
    else
      
      read -r -a hex_arry <<< "$2" 
      
      for part in "${hex_arry[@]}"; do
        echo "part: $part" | tee -a "${log_dir}/arhyas_command.log"
      
        my_hex_string=$(str_to_hex "$part")

        wc_byte2=$( echo "$part" | wc -c )
        echo "byte count2: $wc_byte2" | tee -a "${log_dir}/arhyas_command.log"

        if [[ $wc_byte2 -le 16 ]]; then
          ping -c 6 -p "$my_hex_string" $host | tee -a "${log_dir}/arhyas_command.log"
        else
           echo "warning: $part encoded to $my_hex_string is too long for transmission, sending..." | tee -a "${log_dir}/error.log"
           ping -c 6 -p "$my_hex_string" $host | tee -a "${log_dir}/error.log"
           #r=$(split_send_sp "$my_hex_string" "$part")
        fi
      done

    fi
    IFS=$' \t\n'
}




timeout 15 ping -c 6 $host 
status=$?

if [ $status -eq 124 ]; then
        echo "$host is probably unpingable..."
elif [ $status -ne 0 ]; then
	echo "command failed with status: $status"
else
  while IFS=, read -r field1 field2
  do
    echo "Field 1: $field1"
    hex_string=$(str_to_hex "$field1")
    echo "$hex_string"
    r=$(split_send_hp "$hex_string" "$field1")
    r1=$(split_send_sp "$hex_string" "$field1")
    sleep $((RANDOM % 30))
  done < "$csv_file"
fi
exit 0
