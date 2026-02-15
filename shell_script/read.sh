#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
    command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout;}
    ;;
  Darwin*)
    command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout;}
    ;;
  *)
    ;;
esac

PATH=$PATH:/opt/local/bin:/usr/bin
export PATH

csv_file="$1"
host="$2"
 
str_to_hex() {
    printf '%s' "$1" | od -An -t x1 | tr -d ' \n'
}

timeout 15 ping -c 6 $host 
status=$?

if [ $status -eq 124 ]; then
        echo "$host is probably unpingable..."
elif [ $status -ne 0 ]; then
	echo "command failed with status: $status"
else
  while IFS=, read -r field1 field2
  do
    echo "Field 1: $field1"
    hex_string=$(str_to_hex "$field1")
    #ping -c $((RANDOM % 12)) -p "$hex_string" $host
    #echo ping -c 6 -p "$hex_string" $host
    ping -c 6 -p "$hex_string" $host
    sleep $((RANDOM % 30))
  done < "$csv_file"
fi
exit 0
