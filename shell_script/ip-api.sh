#!/bin/bash

#PATH=$PATH:/opt/local/bin:/usr/bin:/usr/local/bin:/opt/local/sbin:/sbin
#export $PATH

hostlist="$2"
#code="$2"

OS_NAME=$(uname -s)

case "$OS_NAME" in
	Linux*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo apt install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo apt install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jp but it is not installed. Please install jp by: port install jp(mac) or apt install jp(linux). installing..."; sudo apt install jq; }
               
                data_dir=../txt
                ;;
	Darwin*)
		command -v timeout >/dev/null 2>&1 || { echo >&2 "I require timeout but it is not installed. Please install timeout by: port install timeout(mac) or apt install timeout(linux). installing..."; sudo port install timeout; }
		command -v traceroute >/dev/null 2>&1 || { echo >&2 "I require traceroute but it is not installed. Please install timeout by: port install traceroute(mac) or apt install traceroute(linux). installing..."; sudo port install traceroute; }
		command -v jq >/dev/null 2>&1 || { echo >&2 "I require jp but it is not installed. Please install jp by: port install jp(mac) or apt install jp(linux). installing..."; sudo port install jq; }
                data_dir="/Applications/Arhyas Command Multilingual for MacOS 11+.app/Contents/Resources"
                
                ;;
	*)
		;;
esac

#Aborting."; exit 1; }

PATH=$PATH:/opt/local/bin:/usr/bin
export PATH


args=`getopt abo: $*`

# you should not use `getopt abo: "$@"` since that would parse
# the arguments differently from what the set command below does.
if [ $? -ne 0 ]; then
      
       echo "Usage: ip-api.sh -b <list file> for batch or ip-api.sh -s <target> for single target"
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
               echo $hostlist

               build_list=$(cat "$hostlist" | jq -R . | jq -s . )

               command_str="curl http://ip-api.com/batch --data '${build_list}'"
               echo ${command_str}
               eval "${command_str} > '${hostlist}_geo_data.csv'"

               shift;
               ;;
       -s)
               echo "oarg is '$2'"; oarg="$2"
               output=$(curl http://ip-api.com/csv/$hostlist)

	       echo $output >> "$hostlist.csv"
               shift; 
               ;;
       --)
               echo "Usage: ip-api.sh -b <list file> for batch or ip-api.sh -s <target> for single target"
               shift; break
               ;;
       esac
done


