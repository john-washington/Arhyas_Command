#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

#read mypasswd
#perl arhyas_command_mac.pl

target=$1

OS_NAME=$(uname -s)

case "$OS_NAME" in
  Linux*)
      command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: apt install timeout(linux). please run dependency_check.sh. installing..."; sudo apt install timeout;}
      command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by  apt install parallel(linux).  please run dependency_check.sh. install...";  sudo apt install parallel;}
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by or apt install xxd(linux).  please run dependency_check.sh. installing...";  sudo apt install xxd; }
      command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by apt install whois(linux).  please run dependency_check.sh. installed...";  sudo apt install whois;}
      log_dir=../log
      data_dir=../data
      ;;
  Darwin*)
      command -v port >/dev/null 2>&1 || { echo >&2 "I require port but it is not installed. Please install port. installing..."; bash ./install_port.sh; }
    
      command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac).  please run dependency_check.sh. install..."; port install timeout;}
      command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by port install parallel(mac).  please run dependency_check.sh. install...";  port install parallel;}
      
      command -v brew >/dev/null 2>&1 || { echo >&2 "I require brew but it is not installed. Please install brew. install...";   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
      
     
      command -v xxd >/dev/null 2>&1 || { echo >&2 "I require xxd but it is not installed. Please install xxd by brew install xxd(mac) or apt install xxd(linux).  please run dependency_check.sh. existing...";  brew install xxd; }
      command -v whois >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install whois(mac) or apt install whois(linux).  please run dependency_check.sh. existing...";  port install whois;  }
      #command -v csvcut >/dev/null 2>&1 || { echo >&2 "I require whois but it is not installed. Please install whois by port install csvcut(mac) or apt install csvcut(linux).  please run dependency_check.sh. existing...";  port install csvcut;  }
      
      APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
      log_dir="${APP_RES_DIR}/log"
      data_dir="${APP_RES_DIR}/data"
      ;;
  *)
    ;;
esac

mkdir -p "${log_dir}"

timestamp=$(date)

tar -czvf "${data_dir}"."${timestamp}".tar.gz "${data_dir}"
mv "${data_dir}" "${data_dir}"."${timestamp}"

mkdir -p "${data_dir}"

echo Please drop target address files

#read target_addr
column_count=$(head -1 "${target}" | tr -cd ' ' | wc -c | awk '{print $1+1}' )

if [ $column_count -eq 4 ]; then
  bash ./ip-api.sh -s "${target}" | tee -a "${log_dir}/Arhyas_Command.log"
        
elif [ $column_count -eq 2 ]; then

  for i in {1..12}
  do
        echo "Round ${i}"
        cat "${target}" | xargs -n 2 bash ./timeout.sh 
    
        SEC=$((RANDOM % 2400))
        echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
        sleep $SEC
  done

  echo I have run the process 12 times. You can restart or quit.
  echo Thank you for using the program to stop Psychotronic Abuse!
  echo Please provide feedback if you would.
else
  echo Invalid number of columns in input file. Exiting...
  exit 0;
fi