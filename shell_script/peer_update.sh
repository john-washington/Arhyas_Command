#!/bin/bash

#pi_list=("pi-2" "pi-3" "pi-4" "pi-5" "pi-i" "pi-j" "pi-k" "pi-l" "pi-love" "pi-n" "pi-p" "pi-q" "pi-v2" )

#pi_list=("pi-1" "pi-2" "pi-b" "pi-c" "pi-g" "pi-k" "pi-l" "pi-love" "pi-q" "pi-t" "pi-u" "pi-v" "pi-x" "pi-y"  )
pi_list=("pi-g" "pi-p" "pi-t" "pi-w" "pi-4" "pi-5" "pi-i" "pi-love" "pi-j" "pi-q" "pi-v2" "pi-z")
                    
for i in "${!pi_list[@]}";
do
	echo "ssh -t pi@${pi_list[$i]} 'mv ~/Arhyas_Command ~/Arhyas_Command.bak; git clone https://github.peertalk.net:8899/jzhang/Arhyas_Command' "
	#echo "ssh -t pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; git pull' "
	echo "ssh pi@${pi_list[$i]} cat < ../tmp/ip-api.sh.x '>' ip-api.sh.x "
	echo "ssh -t pi@${pi_list[$i]} 'cp ~/ip-api.sh.x ~/Arhyas_Command/shell_script' "
	#echo "ssh -t pi@${pi_list[$i]} 'cp -R Arhyas_Command Arhyas_Command.copy' "
done > jobs_to_run_3

parallel -j ${#pi_list[@]} < jobs_to_run_3

echo "I am done."
exit 0
