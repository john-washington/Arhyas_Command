#!/bin/bash
#code="$1"

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
    command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo apt install xxd; }
    command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; sudo apt install whois; }
    command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo apt install curl; }
    command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by port install jq(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
    APP_RES_DIR=~/Arhyas_Command
    data_dir="${APP_RES_DIR}/data" 
    ;;
  Darwin*)
    command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; sudo port install xxd; }
    command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo port install whois; }
    command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install curl by port install curl(mac) or apt install curl(linux). installing..."; sudo port install curl; }
    command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by port install jq(mac) or apt install jq(linux). installing..."; sudo port install jq; }
    APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
    data_dir="${APP_RES_DIR}"/data
    ;;
  *)
    ;;
esac

count=0
while IFS=':'  read -r F1 F2 F3; do
  #echo "processing: $line"
  if [[ $count -eq 0 ]]; then
      #echo $F1
      #echo ""
      #echo $F2
      #echo ""
      #echo $F3
      cd "$data_dir"
      command_str="jq -c '.[] | select( .query == $F3 ) | { query: .query, lat: .lat, lon: .lon, countryCode: .countryCode, region: .region, city: .city, timezone: .timezone, org: .org }' $F1"
      #echo ${command_str}
      eval "${command_str}"
      command_str2="jq -c '.[] | select( .ip_range_start == $F3 ) | { ip_range_start: .ip_range_start, latitude: .latitude, longitude: .longitude, country_code: .country_code, city: .city, timezone: .timezone, distance: .distance }' $F1"
      #echo ${command_str2}
      eval "${command_str2}"
      #fi
   
  fi
  ((count++))
done 

