#!/bin/bash

#echo $1
  #echo $field3 | tr -d '\%' | echo
#ipfile="$1"

while IFS=' ' read -r field1;
do
 ipfile="$field1"
 echo ${ipfile}
  #logfile=/Users/jzhang/Arhyas_Command/log/Arhyas_Command.log.1
  logfile=/Users/jzhang/Arhyas_Command/log/work/xaa
  APP_RES_DIR=~/Arhyas_Command
  script_dir="${APP_RES_DIR}"/shell_script
  data_dir="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources/data"


  #echo "processing ${ip} on ${logfile}"

  command_txt3="cat ${ipfile} | ./parse_packet_loss.sh > ${ipfile}.trend.csv"
  echo ${command_txt3}
  eval "${command_txt3}"
done < /dev/stdin
