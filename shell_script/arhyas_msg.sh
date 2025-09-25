#!/usr/local/bin/parallel --shebang-wrap /bin/bash

echo "processing IP: $1"
echo "_ELAi_sa_sequence..."
sh read.sh _ELAi_sa_sequence.csv "$1" &
sleep 30
echo "_AL_Hum_Bhra_sequence1..."
sh read.sh _AL_Hum_Bhra_sequence1.csv "$1" &
sleep 30
echo "_AL_Hum_Bhra_sequence2..."
sh read.sh _AL_Hum_Bhra_sequence2.csv "$1" &
sleep 30
echo "_KRP_sequence..."
sh read.sh _KRP_sequence.csv "$1" &
sleep 30
echo "_KRP_Elemental_Command_sequence.csv..."
sh read.sh _KRP_Elemental_Command_sequence.csv "$1" &
sleep 30
echo "_Arhyas_Command_sequence..."
sh read.sh _Arhyas_Command_sequence.csv "$1" &


