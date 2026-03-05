#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH
APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
     
read -s -p "please enter admin password:" mypasswd
echo

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S apt install xxd; }
      ;;
  Darwin*)
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S port install xxd; }
      ;;
  *)
    ;;
esac

#exit 1; }

for i in {1..2048}
do
   echo "REFRESH\n"
   ps -ef | grep 'ping' |  "${APP_RES_DIR}"/parse_monitor.sh 
   SEC=$((RANDOM % 12))
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC

   if [[ $((i % 6)) -eq 0 ]]; then
     echo "checking update..."
     bash "${APP_RES_DIR}"/update.sh $mypasswd
   fi
done
echo 'monitor stop, you can restart...'
