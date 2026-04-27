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
      shell_dir="${APP_RES_DIR}"/shell_script
      log_dir="${APP_RES_DIR}"/log
      data_dir="${APP_RES_DIR}"/data

      ;;
  *)
    ;;
esac


cd "${data_dir}"

#timestamp=$(date | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' | sed '/ /s//_/' )

ls *trace_result.txt > trace_file_list.txt
cat trace_file_list.txt | xargs -o cat > ip_list.txt

cat ip_list.txt | "${shell_dir}"/generate_ip_ping_stats.sh

ls *.ping_stats.csv > ping_stats_list.txt

cat ping_stats_list.txt | "${shell_dir}"/feed_to_parse_packet_loss.sh

