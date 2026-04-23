#!/bin/bash

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      APP_RES_DIR=~/Arhyas_Command
      shell_dir="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}"/log
      data_dir="${APP_RES_DIR}"/data
      ;;
  Darwin*)
      
      #APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      APP_RES_DIR=~/Arhyas_Command
      shell_dir="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}"/log
      data_dir="${APP_RES_DIR}"/data

      ;;
  *)
    ;;
esac

while IFS=' ' read -r field1;
do
  ipfile="$field1"
  echo ${ipfile}
  command_txt3="cat ${ipfile} | "${shell_dir}"/parse_packet_loss.sh > ${ipfile}.trend.csv"
  echo ${command_txt3}
  eval "${command_txt3}"
  julia ${shell_dir}/ip_ping_statis.jl ${ipfile}.trend.csv
done < /dev/stdin
