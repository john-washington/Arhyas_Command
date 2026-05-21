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

#make sure the peer list file has a carriage return at the LAST LINE or it would be missed!!

pi_list=($(cat "${config_dir}"/peer_list.txt | "${shell_script}"/parse_peer_config.sh ))

#for((i=0; i<${#pi_list[@]} ; ++i));
for i in "${!pi_list[@]}";
do
	#echo "$i: ${pi_list[$i]}"
	#echo ""
	#echo "ssh -t pi@${pi_list[$i]} 'reboot'"
	
	#echo "ssh -t pi@${pi_list[$i]} 'mv Arhyas_Command Arhyas_Command.46000; sudo apt install nmap'"

	#echo "ssh -t pi@${pi_list[$i]} 'gunzip -cd Arhyas_Command.tar.gz | tar -xv'"
	

	#echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; ./ping_statistics.sh &'"
	
	#echo "ssh -t pi@${pi_list[$i]} 'sudo curl -fsSL https://install.julialang.org | sh -s;  . /home/pi/.bashrc '"
	#echo "ssh -t pi@${pi_list[$i]} 'mv ~/Arhyas_Command ~/Arhyas_Command.bak; git clone https://github.peertalk.net:8899/jzhang/Arhyas_Command' "
	
	#echo "ssh -t pi@${pi_list[$i]} 'sudo apt install libxml2-utils' "
	
	#echo "ssh -t pi@${pi_list[$i]} 'mv ~/Arhyas_Command ~/Arhyas_Command.bak.washington.dc;'"
	 
	#echo "ssh -t pi@@${pi_list[$i]} 'git clone https://github.peertalk.net:8899/jzhang/Arhyas_Command;' "
	
	#echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; git pull' "
	#echo "ssh pi@${pi_list[$i]} cat < ../tmp/ip-api.sh.x '>' ip-api.sh.x "
	
	#echo "ssh pi@${pi_list[$i]} cat < ip_ping_stats.jl '>' ip_ping_stats.jl "
	#echo "ssh -t pi@${pi_list[$i]} 'cp ~/ip_ping_stats.jl ~/Arhyas_Command/shell_script' "
	
	#echo "ssh pi@${pi_list[$i]} cat < ping_statistics.sh '>' ping_statistics.sh "
	#echo "ssh -t pi@${pi_list[$i]} 'cp ~/ping_statistics.sh ~/Arhyas_Command/shell_script'; "
	
	#echo "ssh pi@${pi_list[$i]} cat < generate_ip_ping_stats.sh '>' generate_ip_ping_stats.sh "
	#echo "ssh -t pi@${pi_list[$i]} 'cp ~/generate_ip_ping_stats.sh ~/Arhyas_Command/shell_script'; "
	
	#echo "ssh -t pi@${pi_list[$i]} 'rm -rf Arhyas_Command.0; rm -rf Arhyas_Command.1; rm -rf Arhyas_Command.46000; rm -rf Arhyas_Command.bak; rm -rf Arhyas_Command.copy; rm -rf Arhyas_Command.tar.gz; rm -rf Arhyas_Command.washington.dc;'"
	echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command; mv data data.18; cd ~/Arhyas_Command/log; mv error.log error.log.18; mv Arhyas_Command.log Arhyas_Command.log.18' "
	
	#echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; ./ping_statistics.sh' "
	#echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; chmod a+x ./feed_to_parse_packet_loss.sh; ./ping_statistics.sh &'"
	#echo "ssh -t pi@${pi_list[$i]} 'ps -A | grep 'ping''
	#echo "ssh -t pi@${pi_list[$i]} 'cp ~/ip-api.sh.x ~/Arhyas_Command/shell_script' "
	#echo "ssh -t pi@${pi_list[$i]} 'cp -R Arhyas_Command Arhyas_Command.copy' "
done > jobs_to_run_3

parallel -j ${#pi_list[@]} < jobs_to_run_3

echo "I am done."
exit 0
