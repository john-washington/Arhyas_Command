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
      
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      #APP_RES_DIR=~/Arhyas_Command
      shell_dir="${APP_RES_DIR}"
      log_dir="${APP_RES_DIR}"/log
      data_dir="${APP_RES_DIR}"/data

      ;;
  *)
    ;;
esac


cd "${data_dir}"

 
timestamp=$(date | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' )

ls *trace_result.txt > trace_file_list_"${timestamp}".txt
cat trace_file_list_"${timestamp}".txt | xargs -o cat > ip_list_"${timestamp}".txt

cat ip_list_"${timestamp}".txt | "${shell_dir}"/generate_ip_ping_stats.sh
