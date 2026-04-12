#!/bin/bash

while IFS=',' read -r field1 field2 field3;
do
  f1=$(echo $field1 | tr -d '^[a-z]')

  f2=$(echo $field2 | tr -d '^[a-z]')
  
  f3=$(echo $field3 | tr -d '^[a-z]' | tr -d '\%')

  echo $f1 ',' $f2 ',' $f3

done < /dev/stdin