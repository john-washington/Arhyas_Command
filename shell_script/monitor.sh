#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo apt install xxd; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; sudo apt install logrotate; }
     
      ;;
  Darwin*)
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo port install xxd; }
     
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; sudo port install logrotate; }
     
      ;;

  *)
    ;;
esac

#exit 1; }

for i in {1..2048}
do
   echo "REFRESH\n"
   ps -ef | grep 'ping' |  ./parse_monitor.sh 
   SEC=$((RANDOM % 12))
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC

   if [[ $((i % 12)) -eq 0 ]]; then
     echo "checking update..."
     bash update.sh
   fi
done
echo 'monitor stop, you can restart...'
