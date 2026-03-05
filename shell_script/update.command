#!/bin/bash

read -s -p "please enter admin password:" mypasswd
echo

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by apt install git(linux). installing..."; echo $mypasswd | sudo -S apt install git; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S apt install logrotate; }
     
      ;;
  Darwin*)
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S port install git; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate; }
     
      TEMP_DIR=~/Documents/Arhyas_Command
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
     
      echo $mypasswd | sudo -S logrotate -v "${APP_RES_DIR}"/Arhyas_Command.logrotate.config

      cd "${TEMP_DIR}"/txt

      #capture both stdout and stderrr
      #OUTPUT=$(git pull 2>&1)
      git pull > git.output | tee -a arhyas_command.log
      
      status=$?
      echo "git pull status: ${status}" | tee -a arhyas_command.log

      grep 'Updating' git.output >/dev/null 2>&1 || { echo >&2 'no new update'; exit 0;}
      #if [ $status -ne 0 ]; then
      
      echo 'updating language files...' | tee -a arhyas_command.log
      rsync -avu "${TEMP_DIR}"/txt/ "${APP_RES_DIR}" | tee -a arhyas_command.log
      echo 'update completed...' | tee -a arhyas_command.log
      
      #rm git.output
      


      ;;
  *)
    ;;
esac





