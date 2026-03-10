#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH
     
read -s -p "please enter admin password:" mypasswd
echo

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
    APP_RES_DIR=~/Arhyas_Command

      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S apt install xxd | tee -a $APP_RES_DIR/Arhyas_Command.log; }
      command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; echo $mypasswd | sudo -S apt install curl; }
    
      ;;
  Darwin*)
  APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"

      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S port install xxd | tee -a $APP_RES_DIR/Arhyas_Command.log; }
      command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; echo $mypasswd | sudo -S port install curl; }
    
      ;;
  *)
    ;;
esac

#exit 1; }

for i in {1..4096}
do
   echo "REFRESH\n"
   reset
   ps -ef | grep 'ping' |  "${APP_RES_DIR}"/parse_monitor.sh 
   SEC=$((RANDOM % 12))
   if [[ $((i % 6)) -eq 0 ]]; then
     echo "checking update..." | tee -a "${APP_RES_DIR}"/Arhyas_Command.log
     bash "${APP_RES_DIR}"/update.sh $mypasswd
     reset
   fi
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..." | tee -a "${APP_RES_DIR}"/Arhyas_Command.log
   sleep $SEC

done

echo 'monitor stop, you can restart...' | tee -a "${APP_RES_DIR}"/Arhyas_Command.log
