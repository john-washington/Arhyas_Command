#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

inputfile="$2"


OS_NAME=$(uname -s)

case "$OS_NAME" in
	Linux*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo apt install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
                data_dir=../data
                txt_dir=../txt
                log_dir=../log
               
                ;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo port install jq; }
                APP_RES_DIR="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
                data_dir="${APP_RES_DIR}/data"
                txt_dir="${APP_RES_DIR}"
                log_dir="${APP_RES_DIR}/log"
                ;;
	*)
		;;
esac

#Aborting."; exit 1; }

PATH=$PATH:/opt/local/bin:/usr/bin
export PATH

mkdir -p "${log_dir}"
mkdir -p "${data_dir}"

args=`getopt abs: $*`

# you should not use `getopt abo: "$@"` since that would parse
# the arguments differently from what the set command below does.
if [ $? -ne 0 ]; then
      
       echo "Usage: ip-api.sh -b <inputfile> for batch api or ip-api.sh -g <inputfilele> for gis circle search api"
       exit 2
fi
set -- $args
# You cannot use the set command with a backquoted getopt directly,
# since the exit code from getopt would be shadowed by those of set,
# which is zero by definition.
while :; do
       case "$1" in
       -a|-b)
               echo "flag $1 set"; 
               #sflags="${1#-}$sflags"
               #build list string here
               echo "${inputfile}"
               build_list=$(cat "${inputfile}" | jq -R . | jq -s . )

               command_str="curl http://ip-api.com/batch --data '${build_list}' | jq . > '${inputfile}_geo_data.json'"
               echo ${command_str}
               eval "${command_str}"

               shift;
               ;;
       -s)
               echo "oarg is '$2'"; oarg="$2"
        
                echo "calling gis api"
                while IFS=' ' read -r lat lon radius language_code;
                  do
                    echo "latidue: $lat longitude: $lon radius: $radius code: $language_code"
                   
                    command_str="curl 'http://gis.peertalk.net:9080/functions/public.circle_search_on_centerpoint/items?center_latitude=${lat}&center_longitude=${lon}&radius=${radius}&limit=1000'"
                    echo ${command_str}
                    eval "${command_str} | jq . > '${data_dir}/center_${lat}_${lon}_${radius}.json'"
                    
                    jq '.[] | .ip_range_start' "${data_dir}/center_${lat}_${lon}_${radius}.json" | tr -d '"' > "${data_dir}/center_${lat}_${lon}_${radius}.txt"
                    cat "${data_dir}/center_${lat}_${lon}_${radius}.txt" |  bash ./append_code.sh  "${language_code}" | xargs -n 2  bash ./timeout2.sh 

                    command_str2="curl 'http://gis.peertalk.net:9080/functions/public.circle_search_on_centerpoint_${language_code}/items?center_latitude=${lat}&center_longitude=${lon}&radius=${radius}&limit=1000'"
                    echo ${command_str2}
                    eval "${command_str2} | jq . > '${data_dir}/center_${lat}_${lon}_${language_code}_${radius}.json'"
                  
                    #jq '.[] | .network' "${data_dir}/center_${lat}_${lon}_${language_code}_${radius}.json" | tr -d '"' > "${data_dir}/center_${lat}_${lon}_${language_code}_${radius}.txt"
                    #this one we need to text process <ip/rang> into some ip
                    #cat "${data_dir}/center_${lat}_${lon}_${language_code}_${radius}.txt" | xargs  bash ./timeout2.sh 
                   


                  done < "$inputfile"
                shift;
                ;;
       --)
               echo "Usage: ip-api.sh -b <inputfile> for batch api or ip-api.sh -s <inputfilele> for gis circle search api"
               shift; break
               ;;
       esac
done


