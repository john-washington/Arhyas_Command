#!/bin/bash

echo Please drop target address files

#read target_addr

for i in {1..1024}
do
      echo "Round ${i}"
      #take care of the target first
      #traceroute may not show the target, so do the rest secondly
      #./arhyas_msg.sh "$1" && traceroute "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
      #cat "$1" | xargs -I {} ./arhyas_msg.sh {} && xargs -I {} traceroute {} | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {} 
      #wc -l "$1"
      cat "$1" | xargs -n 2 sh ./arhyas_msg.sh 
      #&& xargs -I {} traceroute {} | ./tracelist.sh | xargs -n 2 {} ./arhyas_msg.sh {} 
      #PID=$!
      #wait $PID
      SEC=$((RANDOM % 2000))
      echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
      sleep $SEC
done


