#!/bin/bash

while IFS=' ' read -r field1 field2 ;
do
  if [[ $field2 -eq 1 ]]; then
   echo $field1
   echo ""
  fi
done < /dev/stdin