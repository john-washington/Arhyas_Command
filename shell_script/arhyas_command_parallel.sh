#!/bin/bash

#take care of the target first
./arhyas_msg.sh "$1"

#traceroute may not show the target, so do the rest secondly
traceroute "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
	
