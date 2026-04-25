#!/bin/bash
 
#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

#echo $1
OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
    command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo apt install xxd; }
    command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; sudo apt install whois; }
    command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo apt install curl; }
    command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by port install jq(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
    APP_RES_DIR=~/Arhyas_Command
    script_dir="${APP_RES_DIR}"/shell_script
    data_dir="${APP_RES_DIR}/data" 
    ;;
  Darwin*)
    command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo port install xxd; }
    command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo port install whois; }
    command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; sudo port install curl; }
    command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by port install jq(mac) or apt install jq(linux). installing..."; sudo port install jq; }
    APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
    script_dir="${APP_RES_DIR}"/shell_script
    data_dir="${APP_RES_DIR}"/data
    ;;
  *)
    ;;
esac

#Aborting."; exit 1; }

while IFS=' ' read -r field1 field2 field3 field4 field5 field6 field7 field8 field9 field10 field11 field12 field13;
do
  echo ""
  #echo "sent to: $field13"
  #whois $field13 | grep -i country
  echo ""
  echo "mesage: $field12"
  echo ""
  echo "decoded to: "
  mycode=$(echo -n 0x${field12} | xxd -r |  tr -d '\%')
  echo $mycode

  wc_byte=$( echo "$mycode" | wc -c )
  echo ""
  echo "byte count: $wc_byte" 

  #if [[ $wc_byte -le 16 ]]; then
      #ping -c 6 -p "$hex_string" $host
      
      echo "was sent to: $field13"
      echo ""
      
      cd "${data_dir}"
      grep -R "${field13}" *.json | bash "${script_dir}"/parse_colon.sh
 
      grep -R "${field13}" center_*.json | bash "${script_dir}"/parse_colon.sh
      #tr -d ":" 
      cd "${script_dir}"

  #else
  #    echo "$field12 is too long for transmission, sended anyway" 
      #| tee -a monitor_error.log
  #fi

done < /dev/stdin