#!/bin/bash
 
#echo $1

while IFS=' ' read -r field1 field2 field3 field4 field5 field6 field7 field8 field9;
do
  echo ""
  echo "sent to: $field9"
  echo ""
  echo "mesage: $field8"
  echo ""
  echo "decoded to:"
  echo -n 0x${field8} | xxd -r |  tr -d '\%'
done < /dev/stdin


