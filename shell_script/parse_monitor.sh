#!/bin/bash
 
#echo $1
xxd -v >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd. Aborting."; exit 1;}

while IFS=' ' read -r field1 field2 field3 field4 field5 field6 field7 field8 field9 field10 field11 field12 field13;
do
  echo ""
  echo "sent to: $field13"
  echo ""
  echo "mesage: $field12"
  echo ""
  echo "decoded to:"
  echo -n 0x${field8} | xxd -r |  tr -d '\%'
done < /dev/stdin


