#!/bin/bash

pi_list=("pi-1" "pi-2" "pi-b" "pi-c" "pi-g" "pi-k" "pi-l" "pi-love" "pi-p" "pi-q" "pi-t" "pi-u" "pi-v" "pi-x" "pi-y"  )

for i in "${!pi_list[@]}";
do
	#echo "processing: ${pi_list[$i]}"
	#echo "ssh -X pi@${pi_list[$i]} 'cd ~/Arhyas_Command/shell_script; git pull'"
	#echo "updating ip-api.sh.x"
	#echo "ssh pi@${pi_list[$i]} cat < ../tmp/ip-api.sh.x ">" ${pi_list[$i]}"
	#echo "ssh -X pi@${pi_list[$i]} 'cp ip-api.sh.x ~/Arhyas_Command/shell_script'"
	echo "ssh -X pi@${pi_list[$i]} 'cp -R Arhyas_Command Arhyas_Command.copy'"
done > jobs_to_run_3

parallel -j ${#pi_list[@]} < jobs_to_run_3

echo "I am done."
exit 0
