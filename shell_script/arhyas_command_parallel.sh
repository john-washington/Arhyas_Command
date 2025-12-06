#!/bin/bash

for i in {1,2000}
do
   echo "Round ${i}"
   #take care of the target first
   #traceroute may not show the target, so do the rest secondly
   ./arhyas_msg.sh "$1" && traceroute -4 "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
   wait $!
   echo "sleep random seconds..."
   sleep $((RANDOM % 360))
done
	
