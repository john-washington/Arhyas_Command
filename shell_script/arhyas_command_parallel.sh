#!/bin/bash

for i in {1..2000}
do
   echo "Round ${i}"
   #take care of the target first
   #traceroute may not show the target, so do the rest secondly
   ./arhyas_msg.sh "$1" && traceroute  "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
   PID=$!
   wait $PID
   SEC=$((RANDOM % 1200))
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC
done
	
