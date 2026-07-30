#!/bin/bash

read -s -p "please enter admin password:" mypasswd

echo


echo $mypasswd | dependency_check.sh 

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: apt install timeout(linux). installing..."; echo $mypasswd | sudo -S apt install timeout;}
      command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install traceroute by: apt install traceroute(linux). installing..."; echo $mypasswd | sudo -S apt install traceroute;}
     
      command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by apt install parallel(linux). installing..."; echo $mypasswd | sudo -S apt install parallel;}
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by apt install xxd(linux). installing..."; echo $mypasswd |  sudo -S apt install xxd; }
      command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by apt install whois(linux). installing..."; echo $mypasswd |  sudo -S apt install whois; }
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S apt install git; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S apt install logrotate; }
      command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing..."; echo $mypasswd | sudo apt upgrade && sudo -S apt install postgresql; }
        
      ;;
  Darwin*)
      command -v port >/dev/null 2>&1 || { echo >&2 "I require port but it is not installed. Please install port. installing..."; echo $mypasswd | ./install_port.sh;}
      command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install traceroute by: apt install traceroute(linux). installing..."; echo $mypasswd | sudo -S port install traceroute;}
     
      command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; echo $mypasswd | sudo -S port install timeout;}
      command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by port install parallel(mac) or apt install parallel(linux). installing..."; echo $mypasswd | sudo -S port install parallel;}
      
      #command -v brew >/dev/null 2>&1 || { echo >&2 "I require brew but it is not installed. Please install brew. install...";   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
      command -v brew >/dev/null 2>&1 || { echo >&2 "I require brew but it is not installed. installing..."; echo $mypasswd | sudo -S installer -pkg Homebrew.pkg -target / ; }
      
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by port install xxd(mac) or apt install xxd(linux). installing..."; echo $mypasswd | sudo -S port install xxd; }
      command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux). installing..."; echo $mypasswd | sudo -S port install whois; }
      command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it is not installed. Please install git by port install git(mac). installing..."; echo $mypasswd | sudo -S port install git; }
      command -v logrotate >/dev/null 2>&1 || { echo >&2 "I require logrotate but it is not installed. Please install logrotate by port install logrotate(mac) or apt install logrotate(linux). installing..."; echo $mypasswd | sudo -S port install logrotate; }
      command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing...";  brew install postgresql; }
         
      echo $mypasswd | sudo -S installer -pkg Arhyas_Command.pkg -target / ; 
      #echo $mypasswd | sudo -S installer -pkg Arhyas_Command_Monitor.pkg -target / ; 
      #echo $mypasswd | sudo -S installer -pkg Arhyas_Command_pdf.pkg -target / ;
      bash git_clone_init.sh
      APP_DIR=/Applications/
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
     

      #instead of making link, we can just copy the .command file here with the icon already made ahead of time
      echo $mypasswd | sudo -S rmdir -r  "${APP_DIR}/Arhyas Command Monitor.app"
      echo $mypasswd | sudo -S cp "${APP_RES_DIR}/Arhyas Monitor.command" "$APP_DIR"
     
      #figure out ways to see all the log files:

      #figure out ways to see all the target files:, best practise should probably keep data files in app standard location

      ;;
  *)
    ;;
esac

echo "Install complete."
