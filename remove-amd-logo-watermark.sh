#!/bin/sh
# TYPE: Korn Shell script.
# PURPOSE: This korn shell script allows to easily remove AMD/ATI Watermark in AMD graphics drivers for Ubuntu 13.04
# REQUIRES: ksh, Ubuntu 13.04 or newer
# REVISED: 20130403
# AUTHOR: http://www.youtube.com/user/midfingr
# Updated by: Mark Rijckenberg

DRIVER=`find /usr/lib -name fglrx_drv.so`

echo "Come on AMD!"

for token in $DRIVER;do
	echo "Removing AMD logo from "$token

	for x in $(objdump -d $DRIVER|awk '/call/&&/EnableLogo/{print "\\x"$2"\\x"$3"\\x"$4"\\x"$5"\\x"$6}'); do
		sed -i "s/$x/\x90\x90\x90\x90\x90/g" $DRIVER
	done
done

echo "Reboot computer to finish"


