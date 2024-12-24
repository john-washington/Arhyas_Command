#!/bin/bash
 
trace_file="$1"

while IFS=, read -r field1 field2 field3 field4 field5
do
	echo "$field2"
	echo "_ELAi_sa_sequence..."
	sh read.sh _ELAi_sa_sequence.csv "$field2"
	echo "_AL_Hum_Bhra_sequence1..."
	sh read.sh _AL_Hum_Bhra_sequence1.csv "$field2"
	echo "_AL_Hum_Bhra_sequence2..."
	sh read.sh _AL_Hum_Bhra_sequence2.csv "$field2"
	echo "_KRP_sequence..."
	sh read.sh _KRP_sequence.csv "$field2"
	echo "_KRP_Elemental_Command_sequence.csv..."
	sh read.sh _KRP_Elemental_Command_sequence.csv "$field2"
	echo "_Arhyas_Command_sequence..."
	sh read.sh _Arhyas_Command_sequence.csv "$field2"
done < "$trace_file"
