#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

read -s -p "please enter admin password:" mypasswd
echo

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      APP_RES_DIR=~/Arhyas_Command
      shell_script="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}"/log
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S apt install xxd; }
      command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; echo $mypasswd | sudo -S apt install curl; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S apt install logrotate; }
      command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; echo $mypasswd | sudo -S apt install jq; }
      ;;
  Darwin*)
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      shell_script="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}/log" 
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S port install xxd; }
      command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; echo $mypasswd | sudo -S port install curl; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate; }
      command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; echo $mypasswd | sudo -S port install jq; }
      ;;

  *)
    ;;
esac

#exit 1; }

for i in {1..4096}
do
   echo "REFRESH\n"
   ps -ef | grep 'ping' |  "${shell_script}"/parse_monitor.sh 
   SEC=$((RANDOM % 12))
  
   if [[ $((i % 12)) -eq 0 ]]; then
     echo "checking update..." | tee -a "${log_dir}"/Arhyas_Command.log
     bash "${shell_script}"/update.sh $mypasswd
   fi
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..." | tee -a "${log_dir}"/Arhyas_Command.log
   sleep $SEC

done
echo 'monitor stop, you can restart...' | tee -a "${log_dir}"/Arhyas_Command.log
