#!/bin/bash
 

traceroute "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
	
