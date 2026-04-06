#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

inputfile="$2"

mypasswd=$3

OS_NAME=$(uname -s)

case "$OS_NAME" in
	Linux*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo apt install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo apt install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing..."; sudo apt upgrade && sudo apt install postgresql; }
         
                data_dir=../data
                txt_dir=../txt
                log_dir=../log
               
                ;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it is not installed. Please install jq by: port install jp(mac) or apt install jq(linux). installing..."; sudo port install jq; }
        command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it is not installed. Please install psql by: brew install libpq(mac). installing...";  brew install postgresql; }
          
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
               cd "${data_dir}"

               build_list=$(cat "${inputfile}" | jq -R . | jq -s . )

               command_str="curl http://ip-api.com/batch --data '${build_list}' | jq . > '${inputfile}_geo_data.json'"
               echo ${command_str}
               eval "${command_str}"
               
               export PGPASSWORD=xxx
               
               psql -h gis.peertalk.net -p 2048 -d osm -U featureserver -w -c "\copy arhyas_command_tracking(track) FROM PROGRAM 'jq -c -r .[] ${inputfile}_geo_data.json'"

               cd "${APP_RES_DIR}"
               shift;
               ;;
       -s)
               echo "oarg is '$2'"; oarg="$2"
        
                echo "calling gis api"
                while IFS=' ' read -r lat lon radius language_code;
                  do
                    echo "latidue: $lat longitude: $lon radius: $radius code: $language_code"
                    cd "${data_dir}"

                    #special case conversion
                    if [[ $language_code -eq 'zh' ]]; then
                        $language_code='zh_cn'
                    fi

                    if [[ $language_code -eq 'pt' ]]; then
                        $language_code='pt_br'
                    fi

                    command_str="curl 'http://gis.peertalk.net:9080/functions/public.circle_search_on_centerpoint/items?center_latitude=${lat}&center_longitude=${lon}&radius=${radius}&limit=50000'"
                    echo ${command_str}
                    eval "${command_str} | jq . > 'center_${lat}_${lon}_${radius}.json'"
                    
                    jq '.[] | .ip_range_start' "center_${lat}_${lon}_${radius}.json" | tr -d '"' > "center_${lat}_${lon}_${radius}.txt"
                   
                    export PGPASSWORD=xxx
                    
                    psql -h gis.peertalk.net  -p 2048 -d osm -U featureserver -w -c "\copy circle_search_result(result) FROM PROGRAM 'jq -c -r .[] center_${lat}_${lon}_${radius}.json'"
                   
                    command_str2="curl 'http://gis.peertalk.net:9080/functions/public.circle_search_on_centerpoint_${language_code}/items?center_latitude=${lat}&center_longitude=${lon}&radius=${radius}&limit=50000'"
                    echo ${command_str2}
                    eval "${command_str2} | jq . > 'center_${lat}_${lon}_${language_code}_${radius}.json'"
                  
                    jq '.[] | .network' "center_${lat}_${lon}_${language_code}_${radius}.json" | tr -d '"' | sed  's/\/[0-9]\{1,\}//g' > "center_${lat}_${lon}_${language_code}_${radius}.txt"
                  
                    psql -h gis.peertalk.net  -p 2048 -d osm -U featureserver -w -c "\copy circle_search_result_language_coded(result) FROM PROGRAM 'jq -c -r .[] center_${lat}_${lon}_${language_code}_${radius}.json'"
                    
                    cd "${APP_RES_DIR}"
                    
                    cat "${data_dir}/center_${lat}_${lon}_${radius}.txt" |  bash ./append_code.sh  "${language_code}" | xargs -n 2  bash ./timeout.sh 
                    cat "${data_dir}/center_${lat}_${lon}_${language_code}_${radius}.txt" | bash ./append_code.sh  "${language_code}" | xargs  bash ./timeout.sh 
                  
                    
                  done < "$inputfile"
                shift;
                ;;
       --)
               echo "Usage: ip-api.sh -b <inputfile> for batch api or ip-api.sh -s <inputfilele> for gis circle search api"
               shift; break
               ;;
       esac
done


