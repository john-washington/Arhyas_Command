#!/bin/bash

OS_NAME=$(uname -s)

case "$OS_NAME" in
	Linux*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo apt install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing..."; sudo apt upgrade && sudo apt install postgresql; }
                APP_RES_DIR=~/Arhyas_Command
                shell_script="${APP_RES_DIR}"/shell_script
                data_dir="${APP_RES_DIR}"/data
                txt_dir="${APP_RES_DIR}"/txt
                log_dir="${APP_RES_DIR}"/log
                config_dir="${APP_RES_DIR}"/config
                ;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo port install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing...";  brew install postgresql; }
          
                #APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
                APP_RES_DIR=~/Arhyas_Command
                shell_script="${APP_RES_DIR}"/shell_script
                data_dir="${APP_RES_DIR}"/data
                txt_dir="${APP_RES_DIR}"/txt
                log_dir="${APP_RES_DIR}"/log
                config_dir="${APP_RES_DIR}"/config
                ;;
	*)
		;;
esac

pi_list=($(cat "${config_dir}"/peer_list.txt | "${shell_script}"/parse_peer_config.sh ))

for i in "${!pi_list[@]}";
do
	#echo "ssh -t pi@${pi_list[$i]} 'mv ~/Arhyas_Command ~/Arhyas_Command.bak; git clone https://github.peertalk.net:8899/jzhang/Arhyas_Command' "
	#echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; git pull' "
	echo "ssh pi@${pi_list[$i]} cat < ../tmp/ip-api.sh.x '>' ip-api.sh.x "
	echo "ssh -t pi@${pi_list[$i]} 'cp ~/ip-api.sh.x ~/Arhyas_Command/shell_script' "
	#echo "ssh -t pi@${pi_list[$i]} 'cp -R Arhyas_Command Arhyas_Command.copy' "
done > jobs_to_run_3

parallel -j ${#pi_list[@]} < jobs_to_run_3

echo "I am done."
exit 0
