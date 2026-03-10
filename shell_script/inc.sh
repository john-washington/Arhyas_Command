#!/bin/bash

#read -s -p "please enter admin password:" mypasswd
#echo

mypasswd=$1

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      TEMP_DIR=~/Documents/Arhyas_Command
      APP_RES_DIR=~/Arhyas_Command
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by apt install git(linux). installing..."; echo $mypasswd | sudo -S apt install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S apt install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
     
      ;;
  Darwin*)
      TEMP_DIR=~/Documents/Arhyas_Command
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S port install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
     
       ;;
  *)
    ;;
esac


    





