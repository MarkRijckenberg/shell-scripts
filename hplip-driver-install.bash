#!/bin/bash
# Copy-paste following Terminal commands one by one into the Terminal:
# procedure to install printer driver for HP Laserjet 1020 without needing access to openprinting.org website:
URL=http://sourceforge.net/projects/hplip/files/latest/download?source=files
sudo apt-get update
sudo apt-get install axel
cd /tmp
rm hplip*
rm download*
axel $URL
HPLIPVERSION=`head download |grep label|cut -f2 -d" "`
mv download hplip-$HPLIPVERSION.run
# after running the following command, the following question will be asked:
# 'Please choose the installation mode (a=automatic*, c=custom, q=quit) :' 
# choose q to quit (hit <ENTER> key after hitting q key)
# then proceed with next Terminal commands:
bash hplip-$HPLIPVERSION.run
wget http://hplipopensource.com/hplip-web/plugin/hplip-$HPLIPVERSION-plugin.run
sudo bash hplip-$HPLIPVERSION-plugin.run
sudo hp-setup
