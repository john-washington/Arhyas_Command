#!/bin/bash

read -s -p "please enter admin password:" mypasswd

echo

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by apt install git(linux). installing..."; sudo apt install git; }
      ;;
  Darwin*)
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install xxd(mac). installing..."; sudo port install git; }
      TEMP_DIR=~/Documents/Arhyas_Command
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
  
      #cd $TEMP_DIR/shell_script
      cd $TEMP_DIR/txt
      git pull
      cp *.* $APP_RES_DIR
  
      #if [[ ]];
      #  echo $mypasswd | sudo -S installer -pkg Arhyas_Command.pkg -target / ;
      ;;
  *)
    ;;
esac

#exit 1; }


echo 'update completed...'
