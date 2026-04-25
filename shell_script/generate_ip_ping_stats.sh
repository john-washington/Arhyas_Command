#!/bin/bash

#ip=$1
OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      APP_RES_DIR=~/Arhyas_Command
      shell_dir="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}"/log
      data_dir="${APP_RES_DIR}"/data
      ;;
  Darwin*)
      
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      #APP_RES_DIR=~/Arhyas_Command
      shell_dir="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}"/log
      data_dir="${APP_RES_DIR}"/data

      ;;
  *)
    ;;
esac


while IFS=' ' read -r field1;
do
  #echo $field3 | tr -d '\%' | echo
  ip=$field1
  echo ${ip}


  #logfile=/Users/jzhang/Arhyas_Command/log/Arhyas_Command.log.1

  Echo "please take the rotated copy instead of the running log"

  #logfile="${log_dir}"/error.log.1
  #/Users/jzhang/Arhyas_Command/log/work/xaa
  
  echo "processing ${ip} on ${logfile}"

  cd "${log_dir}"

  command_txt="grep -A 1 '${ip} ping statistics' error.log.1 > '${data_dir}/${ip}.ping_stats.txt'"

  echo ${command_txt}

  eval "${command_txt}"

  #grep "[^0.0]% packet loss" 59.37.176.121.ping_stats.txt

  command_txt2="grep '[0-9.0-9]%' '${data_dir}/${ip}.ping_stats.txt' > '${data_dir}/${ip}.ping_stats.csv'"
  echo ${command_txt2}
  eval "${command_txt2}"
  
  command_txt3="cat '${data_dir}/${ip}.ping_stats.csv' | ${shell_dir}/parse_packet_loss.sh > '${data_dir}/${ip}.ping_stats_trend.csv'"
  echo ${command_txt3}
  eval "${command_txt3}"

done < /dev/stdin