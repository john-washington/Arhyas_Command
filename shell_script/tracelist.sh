#!/bin/bash

count=0
while IFS=  read -r line; do
  #echo "processing: $line"
  if [[ $count -gt 1 ]]; then
    for word in $line; do
      if [[ $word =~ ^[a-zA-Z|0-9]{1,3}\.[a-zA-Z|0-9]{1,3}\.[a-zA-Z|0-9]{1,3}(\.[0-9]{1,3})?$ ]]; then
	echo "$word"
      fi
    done
  fi
  ((count++))
done 

