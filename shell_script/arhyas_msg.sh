#!/usr/local/bin/parallel -j24 --shebang-wrap /bin/bash

echo "processing IP: $1"
echo "_ELAi_sa_sequence..."

sh read.sh _ELAi_sa_sequence.csv "$1" &
echo "_AL_Hum_Bhra_sequence1..."
sh read.sh _AL_Hum_Bhra_sequence1.csv "$1" &

echo "_AL_Hum_Bhra_sequence2..."
sh read.sh _AL_Hum_Bhra_sequence2.csv "$1" &

echo "_KRP_sequence...";
#sh read.sh _KRP_sequence.csv "$1" &
sh read.sh _KRP_sequence_beginning.txt "$1" &


language_code="$2"

echo "_KRP_sequence mulitilingual part";
KRP_multilingual_part_filename="_KRP_multilingual_part-${language_code}-dual.txt"
sh read.sh ${KRP_multilingual_part_filename} "$1" &

sh read.sh _KRP_ending.txt "$1" &

echo "_KRP_Elemental_Command_sequence..."
#sh read.sh _KRP_Elemental_Command_sequence.csv "$1" &

KRP_elemental_command_multilingual_part_filename="_KRP_Elemental_Command_sequence-${language_code}-dual.txt"
echo "_KRP_Elemental_Command_sequence_multilingual_part..."
sh read.sh ${KRP_elemental_command_multilingual_part_filename} "$1" &

echo "_12_Strand_DNA_Tribal_Shield_sequence..."
sh read.sh _12_Strand_DNA_Tribal_Shield_sequence.csv "$1" &

ARHYAS_COMMAND_multilingual="_Arhyas_Command_sequence-${language_code}-dual.txt"
echo "_Arhyas_Command_sequence..."
sh read.sh ${ARHYAS_COMMAND_multilingual} "$1" &


