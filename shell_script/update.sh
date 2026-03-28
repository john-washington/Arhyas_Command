#!/bin/bash

#read -s -p "please enter admin password:" mypasswd
#echo

mypasswd=$1

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
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S port install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      data_dir="${APP_RES_DIR}/data"
      txt_dir="${APP_RES_DIR}"
      log_dir="${APP_RES_DIR}/log"
       ;;
  *)
    ;;
esac

echo $mypasswd | sudo -S logrotate -v "${APP_RES_DIR}"/Arhyas_Command.logrotate.config | tee -a "${log_dir}"/Arhyas_Command.log

cd "${TEMP_DIR}"/txt

#capture both stdout and stderrr
#OUTPUT=$(git pull 2>&1)
git config pull.rebase false | tee -a "${log_dir}"/Arhyas_Command.log
git pull > git.output | tee -a "${log_dir}"/Arhyas_Command.log

status=$?
echo "git pull status: ${status}" | tee -a "${log_dir}"/Arhyas_Command.log

grep 'Updating' git.output >/dev/null 2>&1 || { echo >&2 'no new update' | tee -a "${log_dir}"/Arhyas_Command.log; exit 0;}
#if [ $status -ne 0 ]; then

echo 'updating language files...' | tee -a "${log_dir}"/Arhyas_Command.log
rsync -avu "${TEMP_DIR}"/txt/ "${APP_RES_DIR}" | tee -a "${log_dir}"/Arhyas_Command.log
 

echo 'update completed...' | tee -a "${log_dir}"/Arhyas_Command.log

#rm git.output
      


    





