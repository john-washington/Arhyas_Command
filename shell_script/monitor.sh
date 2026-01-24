#!/bin/bash

for i in {1..2048}
do
   ps -A | grep 'ping'
   SEC=$((RANDOM % 12))
   #echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC
done