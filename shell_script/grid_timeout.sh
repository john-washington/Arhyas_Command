#!/bin/bash

#infile=$1
#language_code=$2

OS_NAME=$(uname -s)

case "$OS_NAME" in
    Linux*)
        command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout; }
        command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo apt install traceroute; }
        command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing..."; sudo apt upgrade && sudo apt install postgresql; }
                APP_RES_DIR=~/Arhyas_Command
                shell_script="${APP_RES_DIR}"/shell_script
                data_dir="${APP_RES_DIR}/data"
                txt_dir="${APP_RES_DIR}"/txt
                log_dir="${APP_RES_DIR}/log"
                config_dir=""${APP_RES_DIR}/config"
                ;;
    Darwin*)
        command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
        command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
        command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo port install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing...";  brew install postgresql; }
          
                APP_RES_DIR="/Applications/Arhyas_Command_Multilingual_for_MacOS.app/Contents/Resources"
                #APP_RES_DIR=~/Arhyas_Command
                shell_script="${APP_RES_DIR}"/shell_script
                data_dir="${APP_RES_DIR}/data"
                txt_dir="${APP_RES_DIR}"/txt
                log_dir="${APP_RES_DIR}/log"
                config_dir="${APP_RES_DIR}/config"
                ;;
    *)
        ;;
esac

language_code="$1"
DATA_ITEMS="$2"
#echo "what I am getting:"
#echo "${DATA_ITEMS}"
#echo "\n"

#mypasswd=$(perl "${shell_script}"/arhyas_command_mac.pl | tr -d '0' | tr -d '\n')
#will do password encription later
mypasswd <<< cat "${config_dir}"/passwd.txt
#echo "enter sudo passwd:"
#read mypasswd


#echo "${mypasswd}"

jq -c '.[]' <<<"${DATA_ITEMS}" | while read i;do
   #echo "$i" "${language_code}" |tr -d '"' | tr -d '\n' | tr -d '\n'  
   #echo ""
   echo "${i}" "${langague_code}" "${mypasswd}" | tr -d '"' | tr -d '\n' | tr -d '\n' | xargs -n 3 bash "${shell_script}"/timeout.sh
done

#IFS="|" read -a ip_addrs <<< "${DATA_ITEMS}";
#for i in "${ip_addrs}[@]}"; do
#  echo "item:" "${i}"
#  echo ""
#  #bash "${shell_script}"/timeout.sh ${ip_addr} ${language_code}
#done 
#<<< ${DATA_ITEMS}

#cat $infile |  bash "${shell_script}"/append_code.sh  "${language_code}" | xargs -n 2  bash "${shell_script}"/timeout.sh 

