#!/bin/bash

infile=$1
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
               
                ;;
    Darwin*)
        command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
        command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
        command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo port install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing...";  brew install postgresql; }
          
                #APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
                APP_RES_DIR=~/Arhyas_Command
                shell_script="${APP_RES_DIR}"
                data_dir="${APP_RES_DIR}/data"
                txt_dir="${APP_RES_DIR}"
                log_dir="${APP_RES_DIR}/log"
                ;;
    *)
        ;;
esac

cat $infile |  bash "${shell_script}"/append_code.sh  "${language_code}" | xargs -n 2  bash "${shell_script}"/timeout.sh 

#cat "${data_dir}/center_${lat}_${lon}_${language_code}_${radius}.txt" | bash "${APP_RES_DIR}"/append_code.sh  "${language_code}" | xargs -n 2 bash "${APP_RES_DIR}"/timeout.sh 
   