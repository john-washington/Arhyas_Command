#the command: sudo nmap -Pn -sn --traceroute -oN trace_result.txt 80.95.144.172
#the result file:

# Nmap 7.95 scan initiated Mon May  4 20:13:34 2026 as: nmap -Pn -sn --traceroute -oN trace_result.txt 80.95.144.172
#Nmap scan report for 80.95.144.172
#Host is up (0.27s latency).

#TRACEROUTE (using proto 1/icmp)
#HOP RTT       ADDRESS
#1   ...
#2   335.44 ms 192.168.1.1
#3   378.63 ms 100.64.0.1
#4   ... 10
#11  502.91 ms be3097.ccr41.lax01.atlas.cogentco.com (154.54.40.158)
#12  473.99 ms be3271.ccr41.lax04.atlas.cogentco.com (154.54.42.102)
#13  530.54 ms 38.142.34.194
#14  270.26 ms 80.95.144.172

# Nmap done at Mon May  4 20:13:44 2026 -- 1 IP address (1 host up) scanned in 10.05 seconds


#!/bin/bash
code="$1"
count=0
while IFS=  read -r line; do
  #echo "processing: $line"
  if [[ $count -gt 6 ]]; then
    for word in $line; do
      if [[ $word =~ ^[a-zA-Z|0-9]{1,3}\.[a-zA-Z|0-9]{1,3}\.[a-zA-Z|0-9]{1,3}(\.[0-9]{1,3})?$ ]]; then
	echo "$word" $code
      fi
    done
  fi
  ((count++))
done 

