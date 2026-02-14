#!/bin/bash

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo apt install xxd; }
      ;;
  Darwin*)
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo port install xxd; }
      ;;
  *)
    ;;
esac

#exit 1; }

for i in {1..2048}
do
   ps -ef | grep 'ping' |  ./parse_monitor.sh 
   SEC=$((RANDOM % 12))
   #echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC
done
echo 'monitor stop, you can restart...'
