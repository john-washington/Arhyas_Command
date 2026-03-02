#!/bin/bash

#read -s -p "please enter admin password:" mypasswd
#echo

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      #command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by apt install git(linux). installing..."; sudo apt install git; }
      ;;
  Darwin*)
      #command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install xxd(mac). installing..."; sudo port install git; }
      TEMP_DIR=~/Documents/Arhyas_Command
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
  
      #echo ${APP_RES_DIR}

      cd "${TEMP_DIR}"/txt

      #capture both stdout and stderrr
      #OUTPUT=$(git pull 2>&1)
      git pull > git.output
      
      status=$?
      echo "git pull status: ${status}"

      grep 'Updating' git.output >/dev/null 2>&1 || { echo >&2 'no new update'; exit 0;}
      #if [ $status -ne 0 ]; then
      
      echo 'updating language files...'
      rsync -avu "${TEMP_DIR}"/txt/ "${APP_RES_DIR}"
      echo 'update completed...'
      
      #rm git.output
      


      ;;
  *)
    ;;
esac





