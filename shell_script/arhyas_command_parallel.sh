#!/bin/bash

#echo Please drop target address files:
host="$1"
code="$2"

#read target_addr
timeout 15 ping -4 -c 6 $host
status=$?
if [ $status -eq 124 ]; then
	echo "$1 is probably unpingable..."
elif [ $status -ne 0 ]; then
	echo "command failed with status: $status"
else
   ./arhyas_msg.sh $host $code  
fi
	

#for i in {1..2000}
#do
#   echo "Round ${i}"
   #take care of the target first
   #traceroute may not show the target, so do the rest secondly
   #./arhyas_msg.sh "$1" "$2"  
   traceroute -4 $host | ./tracelist.sh $code | xargs -n 2 sh  ./arhyas_msg.sh 
   #traceroute -4 $host | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {} $code
   #traceroute -4 $host | ./tracelist.sh | xargs -I {} echo {} $code | xargs -n 2  bash ./arhyas_msg.sh 
   #cat "$1" | xargs -I {} traceroute {} | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
   PID=$!
   wait $PID
   SEC=$((RANDOM % 1200))
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC
#done
	
