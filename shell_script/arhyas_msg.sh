#command -v parallel >/dev/null 2>&1 || { echo >&2 "I require parallel but it is not installed. Please install parallel by port install parallel(mac) or apt install parallel(linux). Aborting."; exit 1;}

#!/usr/bin/parallel -j24 --shebang-wrap /bin/bash
host="$1"
language_code="$2"

echo "processing IP: $host"
echo "_ELAi_sa_sequence..."

bash read.sh _ELAi_sa_sequence.csv $host &
echo "_AL_Hum_Bhra_sequence1..."
bash read.sh _AL_Hum_Bhra_sequence1.csv $host &

echo "_AL_Hum_Bhra_sequence2..."
bash read.sh _AL_Hum_Bhra_sequence2.csv $host &

echo "_KRP_sequence...";
#sh read.sh _KRP_sequence.csv "$1" &
bash read.sh _KRP_sequence_beginning.txt $host &

echo "_KRP_sequence mulitilingual part";
KRP_multilingual_part_filename="_KRP_multilingual_part-${language_code}-dual.txt"
bash read.sh ${KRP_multilingual_part_filename} $host &

bash read.sh _KRP_ending.txt $host &

echo "_KRP_Elemental_Command_sequence..."
#sh read.sh _KRP_Elemental_Command_sequence.csv "$1" &

KRP_elemental_command_multilingual_part_filename="_KRP_Elemental_Command_sequence-${language_code}-dual.txt"
echo "_KRP_Elemental_Command_sequence_multilingual_part..."
bash read.sh ${KRP_elemental_command_multilingual_part_filename} $host &

echo "_12_Strand_DNA_Tribal_Shield_sequence..."
bash read.sh _12_Strand_DNA_Tribal_Shield_sequence.csv $host &

ARHYAS_COMMAND_multilingual="_Arhyas_Command_sequence-${language_code}-dual.txt"
echo "_Arhyas_Command_sequence..."
bash read.sh ${ARHYAS_COMMAND_multilingual} $host &

