#!/bin/bash

/usr/bin/say "This process sends Krystal River Prayer and Arhyas Command to your target network"
#command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by port install parallel(mac) or apt install parallel(linux). Aborting."; exit 1;}

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

#!parallel  --shebang-wrap /bin/bash
host="$1"
language_code="$2"


OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      TEMP_DIR=~/Documents/Arhyas_Command
      APP_RES_DIR=~/Arhyas_Command
      data_dir=../data
      txt_dir=../txt
      log_dir=../log
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by apt install git(linux). installing..."; echo $mypasswd | sudo -S apt install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S apt install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
     
      ;;
  Darwin*)
      TEMP_DIR=~/Documents/Arhyas_Command
     
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S port install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      data_dir="${APP_RES_DIR}/data"
      txt_dir="${APP_RES_DIR}"
      log_dir="${APP_RES_DIR}/log"
       ;;
  *)
    ;;
esac



echo "PROGRESS:0"

mkdir -p "${log_dir}"

#echo "logging the ip location"
#result=$(curl "https://ip-api.com/docs/api:csv/$host/?")
#echo $result >> $host.csv

echo "processing IP: $host"
echo "_ELAi_sa_sequence..."

bash read.sh "${txt_dir}/_ELAi_sa_sequence.csv" $host &

echo "PROGRESS:10"
echo "_AL_Hum_Bhra_sequence1..."
bash read.sh "${txt_dir}/_AL_Hum_Bhra_sequence1.csv" $host &

echo "PROGRESS:20"
echo "_AL_Hum_Bhra_sequence2..."
bash read.sh "${txt_dir}/_AL_Hum_Bhra_sequence2.csv" $host &


echo "PROGRESS:30"
echo "_KRP_sequence...";
#sh read.sh _KRP_sequence.csv "$1" &
bash read.sh "${txt_dir}/_KRP_sequence_beginning.txt" $host &

echo "PROGRESS:40"
echo "_KRP_sequence mulitilingual part";
KRP_multilingual_part_filename="_KRP_multilingual_part-${language_code}-dual.txt"
bash read.sh "${txt_dir}/${KRP_multilingual_part_filename}" $host &

bash read.sh "${txt_dir}/_KRP_ending.txt" $host &

echo "PROGRESS:50"
echo "_KRP_Elemental_Command_sequence..."
#sh read.sh _KRP_Elemental_Command_sequence.csv "$1" &

KRP_elemental_command_multilingual_part_filename="_KRP_Elemental_Command_sequence-${language_code}-dual.txt"

echo "PROGRESS:60"
echo "_KRP_Elemental_Command_sequence_multilingual_part..."
bash read.sh "${txt_dir}/${KRP_elemental_command_multilingual_part_filename}" $host &

echo "PROGRESS:70"
echo "_12_Strand_DNA_Tribal_Shield_sequence..."
bash read.sh "${txt_dir}/_12_Strand_DNA_Tribal_Shield_sequence.csv" $host &

echo "PROGRESS:80"
ARHYAS_COMMAND_multilingual="_Arhyas_Command_sequence-${language_code}-dual.txt"
echo "_Arhyas_Command_sequence..."
bash read.sh "${txt_dir}/${ARHYAS_COMMAND_multilingual}" $host &
echo "PROGRESS:100"
echo "Done"

