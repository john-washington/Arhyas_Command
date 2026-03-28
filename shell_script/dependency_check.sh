#!/bin/bash

read mypasswd


OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: apt install timeout(linux). installing..."; echo $mypasswd | sudo -S apt install timeout;}
      command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by apt install parallel(linux). installing..."; echo $mypasswd | sudo -S apt install parallel;}
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by apt install xxd(linux). installing..."; echo $mypasswd |  sudo -S apt install xxd; }
      command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by apt install whois(linux). installing..."; echo $mypasswd |  sudo -S apt install whois; }
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by apt install git(linux). installing..."; echo $mypasswd | sudo -S apt install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S apt install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo apt install curl; }
      command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
     
      ;;
  Darwin*)
      command -v port >/dev/null 2>&1 || { echo >&2 "I require port but it is not installed. Please install port. installing..."; echo $mypasswd | ./install_port.sh;}
      command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; echo $mypasswd | sudo -S port install timeout;}
      command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by port install parallel(mac) or apt install parallel(linux). installing..."; echo $mypasswd | sudo -S port install parallel;}
      command -v brew >/dev/null 2>&1 || { echo >&2 "I require brew but it is not installed. Please install brew. install...";   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
; }
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S port install xxd; }
      command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; echo $mypasswd | sudo -S port install whois; }
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S port install git | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate | tee -a "${APP_RES_DIR}"/arhyas_command.log; }
      command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; sudo port install curl; }
      command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo port install jq; }
     
      ;;
  *)
    ;;
esac
