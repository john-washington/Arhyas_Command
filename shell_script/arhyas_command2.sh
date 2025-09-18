#!/bin/bash
 

traceroute "$1" | while IFS=  read -r line;
do
	echo "processing line: $line"
	for word in $line; do
		if [[ $word =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
			echo "Found IP address: $word"
			echo "_ELAi_sa_sequence..."
			sh read.sh _ELAi_sa_sequence.csv "$word"
			echo "_AL_Hum_Bhra_sequence1..."
			sh read.sh _AL_Hum_Bhra_sequence1.csv "$word"
			echo "_AL_Hum_Bhra_sequence2..."
			sh read.sh _AL_Hum_Bhra_sequence2.csv "$word"
			echo "_KRP_sequence..."
			sh read.sh _KRP_sequence.csv "$word"
			echo "_KRP_Elemental_Command_sequence.csv..."
			sh read.sh _KRP_Elemental_Command_sequence.csv "$word"
			echo "_Arhyas_Command_sequence..."
			sh read.sh _Arhyas_Command_sequence.csv "$word"
		fi
	done
done 
#"$trace_file"
