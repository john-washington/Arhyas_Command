#!/bin/bash

if [$("which parallel") != ""];
then 
   echo "parallel is installed";
else 
   echo "parallel is not installed, installing with brew:";
   if [$("which brew") != "" ];
   then 
      "installing parallel with brew";
   else
      echo "installing brew:"
      /bin/bash -c "$curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo "installing parallel:"
      brew install parallel;
   fi
fi


echo Please drop target address files:

#read target_addr

for i in {1..2000}
do
   echo "Round ${i}"
   #take care of the target first
   #traceroute may not show the target, so do the rest secondly
   #./arhyas_msg.sh "$1" && traceroute "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
   cat "$1" | xargs -I {} ./arhyas_msg.sh {} && xargs -I {} traceroute {} | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
   PID=$!
   wait $PID
   SEC=$((RANDOM % 1200))
   echo "Round ${i} scheduled, sleeping ${SEC} seconds..."
   sleep $SEC
done
	
