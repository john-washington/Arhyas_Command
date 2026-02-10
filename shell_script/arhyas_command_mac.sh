#!/bin/bash
#command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). Aborting."; exit 1; }
#command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by port install parallel(mac) or apt install parallel(linux). Aborting."; exit 1;}

echo Please drop target address files

#read target_addr

for i in {1..12}
do
      echo "Round ${i}"
      #take care of the target first
      #traceroute may not show the target, so do the rest secondly
      #./arhyas_msg.sh "$1" && traceroute "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
      #cat "$1" | xargs -I {} ./arhyas_msg.sh {} && xargs -I {} traceroute {} | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {} 
      #wc -l "$1"
      #cat "$1" | xargs -n 2 sh ./arhyas_msg.sh 
      cat "$1" | xargs -n 2 bash ./timeout.sh 
      #&& xargs -I {} traceroute {} | ./tracelist.sh | xargs -n 2 {} ./arhyas_msg.sh {} 
      #PID=$!
      #wait $PID
      SEC=$((RANDOM % 2000))
      echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
      sleep $SEC
done

echo I have run the process 12 times. You can restart or quit.
echo Thank you for using the program to stop Psychotronic Abuse!
echo Please provide feedback if you would.
