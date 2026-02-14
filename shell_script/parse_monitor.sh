#!/bin/bash
 
#echo $1
OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
    command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo apt install xxd; }
    command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo apt install whois; }
    ;;
  Darwin*)
    command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo port install xxd; }
    command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo port install whois; }
    ;;
  *)
    ;;
esac

#Aborting."; exit 1; }

while IFS=' ' read -r field1 field2 field3 field4 field5 field6 field7 field8 field9 field10 field11 field12 field13;
do
  echo ""
  echo "sent to: $field13"
  whois $field13 | grep -i country
  echo ""
  echo "mesage: $field12"
  echo ""
  echo "decoded to:"
  echo -n 0x${field12} | xxd -r |  tr -d '\%'
done < /dev/stdin


