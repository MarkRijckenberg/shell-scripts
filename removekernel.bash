#!/bin/bash
# TYPE: Bash script.
# PURPOSE: This bash shell script allows to easily remove GNU/Linux kernels. 
# The script should be copied to /usr/bin/removekernel and set as executable. 
# It is a poor man's alternative to Ubuntu Tweak.
# REQUIRES: bash, Ubuntu 12.04 LTS or newer
# REVISED: 20130302
# REVISED: 20130516
# AUTHOR: mark rijckenberg at gmail dot com

   echo "Please press one of the 4 numbers below and then hit the <ENTER> key to execute"

select CHOICE in list-installed-kernels remove-a-specific-kernel remove-all-previous-kernels quit
   do
   case "$CHOICE" in
       
     list-installed-kernels) 
     
     echo "List of currently installed Linux kernels"
     dpkg --list | grep linux-image | egrep '^[r,i]i'  | cut -d" " -f3

     ;;
     remove-a-specific-kernel)  
     
     echo "List of currently installed Linux kernels"
     dpkg --list | grep linux-image | egrep '^[r,i]i'  | cut -d" " -f3
     echo "Please enter kernel package to uninstall from your pc (for example: linux-image-3.9.0-030900rc5-generic) "
     read KERNELVERSION
     apt-cache search $KERNELVERSION|cut -d" " -f1|xargs sudo apt-get remove -y

     ;;  
     remove-all-previous-kernels) 
     
     echo "Will now purge all the following kernel packages:"
     dpkg -l 'linux-*' | grep -v libc| sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'
     dpkg -l 'linux-*' | grep -v libc| sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

     ;; 
     quit)                         
     
     exit
     
     ;;
        esac

   done
