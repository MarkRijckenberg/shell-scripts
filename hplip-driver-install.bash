#!/bin/bash
# Copy-paste following Terminal commands one by one into the Terminal:
# procedure to install printer driver for HP Laserjet 1020 without needing access to openprinting.org website:
#URL=http://sourceforge.net/projects/hplip/files/latest/download?source=files
sudo apt-get update
sudo apt-get remove hplip cups-filters cups hplip-data system-config-printer-udev
sudo apt-get install build-essential tix groff dc axel cups cups-filters unp system-config-printer-gnome
sudo rm -rf /usr/share/hplip
cd /tmp
rm hplip*
rm download*
axel http://foo2zjs.rkkda.com/foo2zjs.tar.gz
unp foo2zjs.tar.gz
cd foo2zjs/
make
./getweb 1020 # Get HP LaserJet 1020 firmware file
sudo make install
sudo make install-hotplug
# Unplug and re-plug the USB printer to the PC
# add new HP Laserjet 1020 printer via system-config-printer tool 
# and choose to use foo2zjs foomatic printer driver :
system-config-printer
# check /var/log/syslog for any errors related to foo2zjs driver:
tail /var/log/syslog

#HPLIPVERSION=`head download |grep label|cut -f2 -d" "`

#mv download hplip-$HPLIPVERSION.run
# after running the following command, the following question will be asked:
# 'Please choose the installation mode (a=automatic*, c=custom, q=quit) :' 
# press <ENTER> to choose (a)utomatic install
# then proceed with next Terminal commands:
#bash hplip-$HPLIPVERSION.run
#wget http://hplipopensource.com/hplip-web/plugin/hplip-$HPLIPVERSION-plugin.run
#sudo bash hplip-$HPLIPVERSION-plugin.run
#sudo hp-setup
#touch ~/.cups/lpoptions

#Troubleshooting

#If the previous procedure does not allow Ubuntu to detect the printer using
#a USB connection, then I suggest

# turning off the printer
# disconnect the printer's USB cable from the PC
# reconnect the printer's USB cable to a different USB port on the PC
# turn the printer back on
# rerun "sudo hp-setup" (last command in previous procedure)

# also try switching from the hpcups printer driver to the foomatic printer driver

#This procedure should solve the error "Device Communication Error, code 5012"
# Source: https://answers.launchpad.net/hplip/+question/249391
