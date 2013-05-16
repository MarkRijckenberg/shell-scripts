#!/bin/bash
# TYPE: Bash script.
# PURPOSE: This bash shell script allows to easily remove GNU/Linux kernels. 
# The script should be copied to /usr/bin/removekernel and set as executable. 
# It is a poor man's alternative to Ubuntu Tweak.
# REQUIRES: bash, Ubuntu 12.04 LTS or newer
# REVISED: 20130302
# REVISED: 20130502
# AUTHOR: markrijckenberg@gmail.com


if [[ $1 == "" ]]; then
echo "List of currently installed kernel .deb packages:"
dpkg --list | grep linux-image | egrep '^[r,i]i'  | cut -d" " -f3
echo "No argument added after removekernel command"
echo "Please enter kernel package to uninstall from your pc (for example: linux-image-3.9.0-030900rc5-generic) "
read KERNELVERSION

echo "Removing kernel package $KERNELVERSION"
apt-cache search $KERNELVERSION|cut -d" " -f1|xargs sudo apt-get remove -y

elif [[ $1 == "all" ]]; then
echo "Removing all previous kernel packages"
dpkg -l 'linux-*' | grep -v libc| sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge


else
echo "Removing kernel package $1"
apt-cache search $1|cut -d" " -f1|xargs sudo apt-get remove -y
fi
