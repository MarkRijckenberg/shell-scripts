#!/bin/bash
# Copy-paste following Terminal commands one by one into the Terminal:
# procedure to install printer driver for HP Laserjet 1020 without needing access to openprinting.org website:
URL=http://sourceforge.net/projects/hplip/files/latest/download?source=files
sudo apt-get update
sudo apt-get install axel
sudo apt-get remove hplip
sudo rm -rf /usr/share/hplip
cd /tmp
rm hplip*
rm download*
axel $URL
HPLIPVERSION=`head download |grep label|cut -f2 -d" "`
mv download hplip-$HPLIPVERSION.run
# after running the following command, the following question will be asked:
# 'Please choose the installation mode (a=automatic*, c=custom, q=quit) :' 
# press <ENTER> to choose (a)utomatic install
# then proceed with next Terminal commands:
bash hplip-$HPLIPVERSION.run
wget http://hplipopensource.com/hplip-web/plugin/hplip-$HPLIPVERSION-plugin.run
sudo bash hplip-$HPLIPVERSION-plugin.run
sudo hp-setup
