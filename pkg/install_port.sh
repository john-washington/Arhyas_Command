#!/bin/bash

macOS_version=$(/usr/bin/sw_vers -productVersion)

IFS=. read -r os_major os_minor os_patch <<< "$macOS_version"


echo "Detected macOS Major Version: $os_major, Minor Version:  $os_minor"

#echo "MacPorts-2.12.1-" os_major "" | sudo installer -pkg -target /

if [[ os_major -ge 11 ]]; then
	PKG_PATH=MacPorts-2.12.1-$os_major*.pkg
else
	PKG_PATH=MacPorts-2.12.1-$os_major.$os_minor*.pkg
fi

echo $PKG_PATH

find . -iname $PKG_PATH -maxdepth 1 -print -exec sudo installer -pkg {} -target / \;


#if [[ -f "PKG_PATH" ]]; then
#	echo "starting installation of $PKG_PATH"
#	#sudo installer -pkg "$PKG_PATH" -target /

if [[ $? -eq 0 ]]; then
	echo "Installation complete."
	exit 0
else
	echo "Installation failed."
	exit 1
fi