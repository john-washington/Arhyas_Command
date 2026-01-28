#!/bin/bash


for i in {1..2048}
do
   ps -ef | grep 'ping' |  ./parse_monitor.sh 
   SEC=$((RANDOM % 12))
   #echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC
done
echo 'monitor stop, you can restart...'