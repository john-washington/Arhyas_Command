#!/bin/bash

while IFS=',' read -r field1 field2 field3 field4;
do
  f1=$(echo $field1 | tr -d '^[a-z]')

  f2=$(echo $field2 | tr -d '^[a-z]')
  
  f3=$(echo $field3 | tr -d '^[a-z]' | tr -d '\%')

  f4=$(echo $field4 | tr -d '^[a-z]' )

  echo $f1 ',' $f2 ',' $f3 ',' $f4

done < /dev/stdin