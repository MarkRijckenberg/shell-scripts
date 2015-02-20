#!/bin/bash
# !!!!! Mac OS X users (v10.9 or newer) should install and use homebrew cask command line tool to install software:
# !!!!! https://github.com/MarkRijckenberg/shell-scripts/blob/master/OSX-restore-packagelist.bash
# !!!!! for semi-automated OS X application deployments and updates
# !!!!! WINDOWS 8.1 64-bit users should use ninite.com and 
# !!!!! https://github.com/MarkRijckenberg/shell-scripts/blob/master/Windows-restore-packagelist.cmd
# !!!!! for semi-automated Windows application deployments and updates
# !!!!! WINDOWS 8.1 64-bit users should install "Classic Start" utility
# !!!!! and disable Superfetch Windows service to avoid hard disk thrashing and excessive memory use
# !!!!! WINDOWS 8.1 64-bit users should use http://www.pendrivelinux.com/yumi-multiboot-usb-creator/  to
# !!!!! to add operating systems one by one in a flexible manner onto a multi-boot multi-OS USB stick
# !!!!! WINDOWS 8.1 64-bit users should install new games via Steam and via www.pokki.com
# !!!!! WINDOWS 8.1 64-bit App Store URL: http://windows.microsoft.com/en-us/windows-8/apps#Cat=t1
# !!!!! WINDOWS 8.1 64-bit Second App Store URL: http://www.pokki.com/

# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily restore packages into a clean install of Xubuntu 14.04 LTS 64-bit
# REQUIRES: Xubuntu 14.04 LTS 64-bit (to support UEFI+SecureBoot+biber+bibtex+bluetooth), cinnamon-bluetooth, 
#           wget, apt-get, unp, wine, biber, biblatex
# CONFLICTS: with Linux Mint and DistroAstro packages!!!!!!! Do not use any package repository except for
# Ubuntu package repositories -> Linux Mint and DistroAstro packages destabilize the GUI interface
# Use Cinnamon instead of Unity interface, because Unity causes Teamviewer sessions to slow down due to window 
# animation in Unity
# REQUIRED FREE DISKSPACE FOR Xubuntu 14.04 LTS: 5 GB of free disk space in root partition
# REQUIRED FREE DISKSPACE FOR BASEPACKAGES:  1.4 GB of free disk space in root partition after installing Linux Mint DVD
# REQUIRED FREE DISKSPACE FOR PPA PACKAGES:  1.4 GB of free disk space in root partition after installing Linux Mint DVD
# TOTAL AMOUNT OF REQUIRED DISKSPACE FOR Xubuntu 14.04 LTS + BASEPACKAGES + PPA PACKAGES
# = 5 GB + 1.4 GB + 1.4 GB = 7.8 GB
# COMPATIBILITY WITH WIRELESS BLUETOOTH SPEAKERS: bluetooth speakers fully work in Linux Mint 16 Cinnamon
# thanks to cinnamon-bluetooth package.
# To make bluetooth speakers work in lxqt desktop, run these 4 Terminal commands:
# 1) pactl list | grep -i module-bluetooth-discover
# 2) pactl load-module module-bluetooth-discover
# 3) pavucontrol   
# 4) sudo apt-get remove blueman
#  -> select bluetooth speakers as output in pavucontrol

# INSTALL DURATION: 20 minutes for install of Linux Mint + 74 minutes for install of base packages and PPA packages
# Author: Mark Rijckenberg
# Copyright (c) 20120812
# REVISION DATE: 20141017
# Updated by: markrijckenberg at gmail dot com

# regarding the HP Laserjet 1020 in Berlin:
# procedure to install printer driver for HP Laserjet 1020 without needing access to openprinting.org website:
# see https://github.com/MarkRijckenberg/shell-scripts/blob/master/hplip-driver-install.bash

#sudo su
PATH=/usr/sbin:/usr/bin:/sbin:/bin
#Prerequisites: USB drives SAMSUNG and IOMEGA need to be mounted correctly in order for this script to work correctly!

MACHINE_TYPE=`uname -m`

# define Astronomy filename variables
SCISOFTFILENAME="7.7.0"
C2AFILENAME="c2a_full_2_0_49.zip"
AUDELAFILENAME="audela-2.0.0"

#define source directories
HOME=$(eval echo ~${SUDO_USER})
SOURCE2=/etc/
SOURCE3=/media/windows/rsync/


#define target directories where backup will be stored
cd $HOME
TARGET1=/media/SAMSUNG/$HOME/
TARGET2=/media/IOMEGA/$HOME/
TARGET3=/media/SAMSUNG/etc/
TARGET4=/media/IOMEGA/etc/
TARGET5=/media/SAMSUNG/media/windowsdata/rsync/
TARGET6=/media/IOMEGA/media/windowsdata/rsync/
ZIP=zip/
TAR=tar/
PDF=pdf/
DEB=deb/
KMZ=kmz/
mkdir $ZIP
mkdir $TAR
mkdir $PDF
mkdir $DEB
mkdir $KMZ
mkdir triatlas

# clean up current directory
echo "Performing file cleanup"
cd $HOME
mv *.deb $DEB
rm *.exe
mv *.km? $KMZ
mv *.pdf $PDF
mv *gz $TAR
mv *.zip $ZIP
rm *.cab
rm *.crt
rm .goutputstrea*
rm *.html
rm *.sh
rm *.xpi
rm ica_*
rm google*
sudo rm /etc/apt/sources.list.d/*


#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $TARGET1 $HOME 
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $TARGET2 $HOME
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $TARGET3 $SOURCE2
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $TARGET4 $SOURCE2 
# not required during restore: sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $TARGET5 $SOURCE3
# not required during restore: sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $TARGET6 $SOURCE3
#sudo DEBIAN_FRONTEND=noninteractive apt-get install dselect rsync -y
#sudo DEBIAN_FRONTEND=noninteractive apt-key add $TARGET1/Repo.keys
# sudo DEBIAN_FRONTEND=noninteractive apt-key add Repo.keys
#sudo dpkg --set-selections < $TARGET1/Package.list
#sudo dpkg --set-selections < Package.list
#sudo dselect

#sudo cp /etc/apt/sources.list  /etc/apt/sources.list.backup
#sudo cp sources.list.12.04 /etc/apt/sources.list

###############################################################################################
#     BASE PACKAGES SECTION                                                                   #
###############################################################################################

# delete old custom aliases in ~/.bashrc file
egrep -v 'alias\ apt|alias\ d-u|wget'  ~/.bashrc > ~/.bashrcBACKUP
cp ~/.bashrcBACKUP ~/.bashrc

# define custom aliases in ~/.bashrc file
echo "alias apti='sudo aptitude update && sudo aptitude install '" >> ~/.bashrc
echo "alias aptr='sudo aptitude remove '" >> ~/.bashrc
echo "alias aptp='sudo aptitude purge '" >> ~/.bashrc
echo "alias aptu='sudo aptitude update'" >> ~/.bashrc
echo "alias apts='sudo aptitude search '" >> ~/.bashrc
echo "alias d-u='sudo aptitude update && sudo aptitude dist-upgrade'" >> ~/.bashrc
echo "alias wget='wget --no-check-certificate'" >> ~/.bashrc
alias wget="wget --no-check-certificate"

# turn off apport error/crash reporting
sudo sed -i s/enabled=1/enabled=0/ /etc/default/apport

##########################################################################################################
# add base PPA repositories
##########################################################################################################

sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:hsoft/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:lubuntu-dev/lubuntu-daily
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:gilir/q-project
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:danielrichter2007/grub-customizer
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:libreoffice/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:mjblenner/ppa-hal
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:i-nex-development-team/daily
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:nemh/gambas3
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:peterlevi/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:linrunner/tlp
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:kazam-team/stable-series
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:dhor/myway
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:finalterm/daily
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:webupd8team/atom
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:philip5/extra
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:openshot.developers/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:stebbins/handbrake-releases
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:lyc256/sopcast-player-ppa
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:surfernsk/internet-software
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:makson96/desurium
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:noneed4anick/cuttlefish
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:tualatrix/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:webupd8team/y-ppa-manager
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:ubuntu-wine/ppa 
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:oibaf/graphics-drivers
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:noobslab/apps
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:gertvdijk/opensc-backports
# very important security related PPA that was the first repository to fix the 
# CVE-2014-6277 bash shellshock vulnerability on October 8, 2014: 
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:ubuntu-security-proposed/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:numix/ppa
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:fish-shell/release-2
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:marutter/rrutter
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:marutter/c2d4u

##########################################################################################################
# add astronomy PPA repositories
##########################################################################################################
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:mutlaqja/astrometry.net
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:mutlaqja/ppa

# Do NOT add repository for distroastro software packages
# Distroastro v3.0.1 breaks the windowing functionality of metacity and does not work well
# Distroastro mixes packages from Ubuntu and Linux Mint, causing severe issues
# replace codename (for example: trusty) with right Ubuntu codename
#RELEASE=`awk -F'[" ]' '/VERSION=/{print $3}' /etc/os-release| awk '{print tolower($0)}'`
#sudo touch /etc/apt/sources.list.d/distroastro.list
#sudo sh -c 'echo "deb http://packages.distroastro.org/distroastro juno free non-free" >> /etc/apt/sources.list.d/distroastro.list'
#sudo sh -c 'echo "deb-src http://packages.distroastro.org/distroastro juno free non-free" >> /etc/apt/sources.list.d/distroastro.list'
#wget -qO - http://packages.distroastro.org/key | sudo apt-key add -

# add repository for eid-mw and eid-viewer software packages
# replace codename (for example: trusty) with right Ubuntu codename
RELEASE=`awk -F'[" ]' '/VERSION=/{print $3}'  /etc/os-release| awk '{print tolower($0)}'`
sudo touch /etc/apt/sources.list.d/eid.list
sudo sh -c 'echo "deb http://files.eid.belgium.be/debian trusty main" >> /etc/apt/sources.list.d/eid.list'

# add repository for google music manager software package
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# add partner repository for skype software package
# replace codename (for example: trusty) with right Ubuntu codename
sudo touch /etc/apt/sources.list.d/partner.list
sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu trusty partner" >> /etc/apt/sources.list.d/partner.list'
sudo sh -c 'echo "deb-src http://archive.canonical.com/ubuntu trusty partner" >> /etc/apt/sources.list.d/partner.list'

##########################################################################################################
# refresh list of available packages in Ubuntu repositories
sudo DEBIAN_FRONTEND=noninteractive apt-key add Repo.keys
sudo DEBIAN_FRONTEND=noninteractive apt-get update
##########################################################################################################

# install list of packages defined in packages files
# allpackages = basepackages + astropackages
# sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install `cat  allpackages` -o APT::Install-Suggests="false"

# commented out following line, because it will break bluetooth support in Linux Mint
# sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge pulseaudio*
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge arno-iptables-firewall
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge ufw
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge blueman

##########################################################################################################
# install Citrix Receiver icaclient in Ubuntu 14.04 LTS - only works using Mozilla Firefox, not using Google Chrome
# source 1:  http://ubuntuforums.org/showthread.php?t=2181903
# source 2:  http://blog.vinnymac.org/?p=351
# source 3:  https://help.ubuntu.com/community/CitrixICAClientHowTo
##########################################################################################################
cd $HOME
mv $HOME/.ICAClient $HOME/.ICAClient_save 
sudo dpkg -P icaclient
rm -rf $HOME/foo
sudo dpkg --add-architecture i386 # only needed once
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install firefox apt-file git nspluginwrapper lib32z1 libc6-i386 libxml2:i386 libstdc++6:i386 libxerces-c3.1:i386 libcanberra-gtk-module:i386 libcurl3:i386 libasound2-plugins:i386 libgstreamer-plugins-base0.10-0:i386 openssl ca-certificates
sudo apt-file update --architecture i386
sudo apt-file update --architecture amd64
git clone https://github.com/CloCkWeRX/citrix-receiver-ubuntu-fixed.git foo
find foo/opt/Citrix/ICAClient/ -exec file {} ';' | grep "ELF" | grep "executable" > ica_elf_list
cat ica_elf_list | while read f; do arch=$(echo "$f" | grep -o '..-bit' | sed 's/32-bit/i386/' | sed 's/64-bit/amd64/'); file=$(echo "$f" | awk '{print $1}' | sed 's/://g'); ldd "$file" | sed "s/^/$arch/g"; done | sort | uniq > ica_so_list
cat ica_so_list | awk '{print $4}' | grep '^/' | sort | uniq | while read f; do dpkg -S "$f"; done > ica_deb_list
cat ica_deb_list | awk '{print $1}' | sed 's/:$//g' | sort | uniq > ica_deb_list_final
cat ica_so_list | grep "not found" > ica_so_missing
cat ica_so_missing | while read f; do arch=$(echo "$f" | awk '{print $1}'); file=$(echo "$f" | awk '{print $2}'); apt-file find -x "$file$" -a $arch | sed "s/: /:$arch provides /g"; done > ica_missing_packages
cat ica_missing_packages | awk '{print $3}' | sort | uniq | while read provided; do providers=$(grep "provides $provided" ica_missing_packages | awk '{print $1}'); count=$(echo $providers | wc -w); selected=$providers; if [ $count -gt 1 ]; then echo "Multiple packages can provide $provided, please select one:" >&2; select selected in $providers; do break; done < /dev/tty; echo "You selected $selected" >&2; fi; echo $selected; done > ica_selected_packages
missing=$(cat ica_selected_packages | awk '{print $1}'); sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes   install $missing
cat ica_elf_list | while read f; do arch=$(echo "$f" | grep -o '..-bit' | sed 's/32-bit/i386/' | sed 's/64-bit/amd64/'); file=$(echo "$f" | awk '{print $1}' | sed 's/://g'); ldd "$file" | sed "s/^/$arch/g"; done | sort | uniq > ica_so_list
cat ica_so_list | awk '{print $4}' | grep '^/' | sort | uniq | while read f; do dpkg -S "$f"; done > ica_deb_list
cat ica_deb_list | awk '{print $1}' | sed 's/:$//g' | sort | uniq > ica_deb_list_final
cat ica_so_list | grep "not found" > ica_so_missing
cat ica_so_missing | while read f; do arch=$(echo "$f" | awk '{print $1}'); file=$(echo "$f" | awk '{print $2}'); apt-file find -x "$file$" -a $arch | sed "s/: /:$arch provides /g"; done > ica_missing_packages
# make sure  ica_so_missing file is now empty:
cat ica_so_missing
checked=""; unnecessary=""; unchecked="$(cat ica_deb_list_final) EOF"; while read -d ' ' f <<< $unchecked; do checked="$f $checked"; candidates=$(apt-cache depends "$f" | grep '\sDepends' | awk '{print $2}' | sed 's/[<>]//g'); unchecked="$(for d in $candidates; do if ! grep -q $d <<< $checked; then echo -n "$d "; fi; done) $unchecked"; unchecked="$(echo $unchecked | sed "s/$f //g")"; unnecessary="$(for d in $candidates; do if ! grep -q $d <<< $unnecessary; then echo -n "$d "; fi; done) $unnecessary"; done; for u in $unnecessary; do echo "$u"; done > ica_implicit_dependencies
original=$(cat ica_deb_list_final); for f in $original; do if ! grep -q $f ica_implicit_dependencies; then echo "$f"; fi; done > ica_explicit_dependencies
sed -i 's/grep "i\[0-9\]86"/grep "i\\?[x0-9]86"/g' foo/DEBIAN/postinst
new_depends="$(cat ica_explicit_dependencies | tr '\n' ',') nspluginwrapper"; sed -i "s/^Depends: .*$/Depends: $new_depends/" foo/DEBIAN/control
rm -rf foo/opt/Citrix/ICAClient/keystore/cacerts
ln -s /etc/ssl/certs foo/opt/Citrix/ICAClient/keystore/cacerts
mkdir -p foo/usr/share/applications
printf '[Desktop Entry]\nName=Citrix ICA client\nComment="Launch Citrix applications from .ica files"\nCategories=Network;\nExec=/opt/Citrix/ICAClient/wfica\nTerminal=false\nType=Application\nNoDisplay=true\nMimeType=application/x-ica' > foo/usr/share/applications/wfica.desktop
dpkg -b foo icaclient_amd64_fixed_for_14.04_LTS.deb
sudo dpkg -i icaclient_amd64_fixed_for_14.04_LTS.deb
sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts/
xdg-mime default wfica.desktop application/x-ica

# Thank you Michael May for reminding me to add the following step:
# Click on the “open menu” icon in the top right corner of the Mozilla Firefox interface.
# Then click on the Add-ons icon
# Click on Plugins and then on “Citrix Receiver for Linux”
# Choose “Always activate” option next to “Citrix Receiver for Linux”
# Attempt to access your Citrix site. If Firefox prompts you to open a .ica file, choose
# to open it with /opt/Citrix/ICAClient/wfica.sh, and tell Firefox to remember that choice.

##########################################################################################################
# install eid card reader middleware - replace codename (for example: trusty) with right Ubuntu codename
# Supported CCID readers:   http://pcsclite.alioth.debian.org/ccid/section.html
##########################################################################################################

# Supported CCID readers:   http://pcsclite.alioth.debian.org/ccid/section.html
cd $HOME
# RELEASE = saucy,trusty, etc...... = distribution codename
#RELEASE=`awk -F'[" ]' '/VERSION=/{print $3}'  /etc/os-release| awk '{print tolower($0)}'`
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com A35743EA6773D225
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove --purge beid*
#sudo touch /etc/apt/sources.list.d/eid.list
#sudo sh -c 'echo "deb http://files.eid.belgium.be/debian trusty main" >> /etc/apt/sources.list.d/eid.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  usbutils pciutils eid-mw eid-viewer aptitude  firefox pcscd  default-jre  opensc libacr38u libacr38ucontrol0 libacsccid1  libccid libudev-dev libusb-1.0-0 libpcsclite1 libpcsclite-dev pcsc-tools  libnss3-tools ca-certificates
sudo update-pciids
sudo update-usbids

cd $HOME/.mozilla/firefox/*.default

rm extensions*
rm -rf extensions/*
rm addons*
sudo rm -rf /usr/lib/firefox/browser/extensions*

cp prefs.js prefs.js_backup_`date -I`
grep -v security.ssl prefs.js > prefs.js.nossl.1
grep -v security.tls.version.min prefs.js.nossl.1 > prefs.js.nossl.2
grep -v extensions.enabled prefs.js.nossl.2 > prefs.js.nossl 

echo 'user_pref("security.ssl.allow_unrestricted_renego_everywhere__temporarily_available_pref", true);' >> prefs.js.nossl
echo 'user_pref("security.ssl.enable_false_start", true);' >> prefs.js.nossl
echo 'user_pref("security.ssl.renego_unrestricted_hosts", "*.be");' >> prefs.js.nossl
# protect Mozilla Firefox v33 or lower against POODLE SSLv3 vulnerability:
echo 'user_pref("security.tls.version.min", "1");' >> prefs.js.nossl

cp prefs.js.nossl prefs.js

cd $HOME

rm *.crt*

wget http://certs.eid.belgium.be/belgiumrs.crt
certutil -d sql:$HOME/.pki/nssdb -A -t "c,T,C" -n belgiumrs -i belgiumrs.crt

wget http://certs.eid.belgium.be/belgiumrs2.crt
certutil -d sql:$HOME/.pki/nssdb -A -t "c,T,C" -n belgiumrs2 -i belgiumrs2.crt

wget http://certs.eid.belgium.be/belgiumrs3.crt
certutil -d sql:$HOME/.pki/nssdb -A -t "c,T,C" -n belgiumrs3 -i belgiumrs3.crt

wget http://certs.eid.belgium.be/belgiumrs4.crt
certutil -d sql:$HOME/.pki/nssdb -A -t "c,T,C" -n belgiumrs4 -i belgiumrs4.crt


sudo mkdir /usr/share/ca-certificates/extra

sudo cp belgiumrs.crt /usr/share/ca-certificates/extra/belgiumrs.crt
sudo cp belgiumrs2.crt /usr/share/ca-certificates/extra/belgiumrs2.crt
sudo cp belgiumrs3.crt /usr/share/ca-certificates/extra/belgiumrs3.crt
sudo cp belgiumrs4.crt /usr/share/ca-certificates/extra/belgiumrs4.crt

sudo dpkg-reconfigure ca-certificates

sudo certutil -d sql:$HOME/.pki/nssdb -A -t "c,T,C" -n ca-certificates-new-2014 -i /etc/ssl/certs/ca-certificates.crt



#Manually set the following values in Mozilla Firefox in about:config
#security.ssl.allow_unrestricted_renego_everywhere__temporarily_available_pref;true
#security.ssl.enable_false_start;true
#security.ssl.renego_unrestricted_hosts;*.be

#Manually replace the security.ssl.renego_unrestricted_hosts name
#certif.belgium.be or *.be in about:config,  if you want to authenticate on a DIFFERENT site than www.cm.be or test.eid.belgium.be !!!
#Download Belgium Root certificates here:
#http://repository.eid.belgium.be/certificates.php?cert=Root&lang=en
#Import Belgium Root certificates into Firefox.
#The Belgium Root certificates are required if you want to use the applications of the FSP Finance (Belcotax, Intervat, Finprof, etc.).
#Before you begin, make sure your identity card is in the card reader. Then:
#Viewing certificates
#For Linux: Go to Edit > Preferences > Advanced > Encryption and click ‘View certificates’.
#Check-marking certificates
#Follow the steps below for the ‘Belgium Root CA’ and ‘Belgium Root CA2’ certificates. Can you only find one certificate? Then you obviously only have to perform these steps once.
#Find the ‘Belgium Root CA’ or ‘Belgium Root CA2’ certificate and click the line below the arrow.
#Click ‘Edit…’.
#Check ALL three boxes.
#Click ‘OK’.
#Ensure that there are absolutely NO add-ons or plugins installed in Mozilla Firefox.
#Installing the Belgium eid Firefox add-on will NOT work in Ubuntu 13.10 64-bit and only make matters worse!
#Disconnect the eid card reader from the PC.
#Reconnect the eid card reader to the PC.
#Insert eid card into card reader.
#Reboot the PC.
#Test eid card reader here:
#http://test.eid.belgium.be/
#Source: http://wiki.yobi.be/wiki/Belgian_eID




# install dupeguru-me which can find and delete similar music filenames using fuzzy logic
# rerun dupeguru-me on /media/IOMEGA/downloads/Youtube-playlists  after each mp3 conversion using YouTubeToMP3
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:hsoft/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install dupeguru-me

# Install lxqt desktop environment => merge of lxde and razorqt desktops
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:lubuntu-dev/lubuntu-daily
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:gilir/q-project
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  lxqt-metapackage lxqt-panel openbox
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  liblxqt0 libqtxdg0 libqtxdg-data 
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  pcmanfm-qt  lxsession lximage-qt   lxrandr-qt
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  lxqt-about  lxqt-appswitcher  lxqt-config   lxqt-lightdm-greeter  
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  lxqt-notificationd    lxqt-policykit  lxqt-power  lxqt-powermanagement  lxqt-runner  lxqt-session
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  lxqt-metapackage


#install  numix-icon-theme-circle (choose numix circle icon theme via lxqt start menu button
# then click on Preferences::Appearance::Icons Theme::Numix Circle Light
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  numix-icon-theme-circle

##########################################################################################################
# install base packages using basepackages file
cd $HOME/shell-scripts
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install aptitude
sudo DEBIAN_FRONTEND=noninteractive aptitude install `cat basepackages` -o APT::Install-Suggests="false"
cd $HOME
##########################################################################################################

# create symbolic link to wkhtmltopdf in /usr/local/bin after installing base packages
sudo ln -s /usr/bin/wkhtmltopdf /usr/local/bin/html2pdf

# install grub customizer
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:danielrichter2007/grub-customizer
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install grub-customizer

# install newest version of Libreoffice
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:libreoffice/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install libreoffice

#install deprecated, obsolete hal package so that fluendo content and DRM-demanding
# Flash websites are supported in Lubuntu 13.10 or newer
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:mjblenner/ppa-hal
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install hal

#install i-nex - I-nex is similar to CPU-Z in Windows, it uses the same interface to display your hardware information.
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:i-nex-development-team/daily
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:nemh/gambas3
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install i-nex 

# install Variety - cool wallpaper changer
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:peterlevi/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install variety

#install pipelight which allows to run your favorite Silverlight application directly inside your Linux browser
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository  --yes ppa:ehoover/compholio
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository  --yes ppa:mqchael/pipelight
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install pipelight

# install google-talkplugin
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo DEBIAN_FRONTEND=noninteractive apt-key add - 
#sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install google-talkplugin

# install daily build of firefox-trunk (bleeding edge browser)
#sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes purge firefox
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:ubuntu-mozilla-daily/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install firefox-trunk

# Install TLP - advanced power management command line tool for Linux
# TLP saves more laptop power than standard Ubuntu package laptop-mode-tools
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:linrunner/tlp
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install tlp tlp-rdw

# Install kazam screen recording tool for Ubuntu 12.04 / 12.10 / 13.04
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:kazam-team/stable-series
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install kazam

# install hotshots Screen Capture Tool In Ubuntu 12.04 / 12.10 / 13.04
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:dhor/myway
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install hotshots

# install Final Term - excellent Terminal emulator in  Ubuntu 12.04 / 12.10 / 13.04
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:finalterm/daily
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install finalterm

# install xiki shell - A shell console with GUI features 
# http://xiki.org
# source: https://github.com/trogdoro/xiki

cd $HOME
rm -rf xiki
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  ruby1.9.3 ruby-dev
git clone git://github.com/trogdoro/xiki.git
cd xiki
sudo gem install bundler   # <- no "sudo" if using rvm
bundle                # <- no "sudo" if using rvm
sudo ruby etc/command/copy_xiki_command_to.rb /usr/bin/xiki
xiki web/start
# then navigate to http://localhost:8161/dbs
# to view the locally installed mysql databases, tables and fields
cd $HOME


# install Google Music Manager - sync local mp3s in Ubuntu with ios or Android device
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#sudo sh -c 'echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install google-musicmanager-beta
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install google-musicmanager

# install newest version of VLC player
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:videolan/master-daily
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install vlc

# install newest version of smtube (Youtube player)
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install libqtgui4 libqt4-xml libqt4-network libqt4-dbus phonon-backend-vlc
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install smtube

# install spotify - can sync mp3 files between Ubuntu 13.10 and ipod nano 6th generation
#sudo DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
#sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install spotify-client

# install atom text editor with integrated github support
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes  ppa:webupd8team/atom
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install atom

# install kdenlive video editor
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes  ppa:philip5/extra
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install kdenlive

# install openshot which is a simple and easy to use video editor, like a good substitute for the windows movie maker
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:openshot.developers/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install openshot

# install Handbrake - open source video transcoder - add Subtitles (VobSub, Closed Captions CEA-608, SSA, SRT)
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:stebbins/handbrake-releases
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install handbrake 

# install SopCast webTV player
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:lyc256/sopcast-player-ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install sopcast-player 

# install qbittorrent client
# import RSS feeds from http://showrss.info/?cs=feeds  into qbittorrent client
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:surfernsk/internet-software
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install qbittorrent


# install desurium game client
#sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:makson96/desurium
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install desurium

# install 64-bit compatible Steam client
wget media.steampowered.com/client/installer/steam.deb
sudo dpkg -i steam.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

##########################################################################################################
# install LGOGDownloader game client (unofficial downloader to GOG.com for Linux users) 
# It uses the same API as the official GOGDownloader.
##########################################################################################################
cd
rm -rf $HOME/lgogdownloader
git clone https://github.com/Sude-/lgogdownloader.git
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  build-essential libcurl4-openssl-dev liboauth-dev libjsoncpp-dev libhtmlcxx-dev libboost-system-dev libboost-filesystem-dev libboost-regex-dev libboost-program-options-dev libboost-date-time-dev libtinyxml-dev librhash-dev help2man
cd lgogdownloader
sudo make release
sudo make install

#compile and install newest version of openssl in Ubuntu 14.04 LTS
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install checkinstall build-essential
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes build-dep openssl
sudo rm -rf ~/openssl
git clone https://github.com/openssl/openssl.git
cd openssl
sudo ./config
sudo make
sudo make test
sudo checkinstall
sudo rm -rf ~/openssl
sudo mv /usr/bin/c_rehash /usr/bin/c_rehashBACKUP
sudo mv /usr/bin/openssl /usr/bin/opensslBACKUP
sudo ln -s /usr/local/ssl/bin/c_rehash /usr/bin/c_rehash
sudo ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
openssl version
apt-cache show openssl

# install kde plasma 5 desktop environment
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:neon/kf5
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes   install project-neon5-session project-neon5-utils project-neon5-konsole project-neon5-plasma-workspace-wallpapers project-neon5-breeze

# Cuttlefish is an ingenious little tool. It allows you to define a set of actions that occur when a certain stimulus is activated.
# sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:noneed4anick/cuttlefish
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install cuttlefish 

# Install Ubuntu Tweak to easily uninstall old kernel versions
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:tualatrix/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install ubuntu-tweak

# install skype
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  remove skype skype-bin
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install skype
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 sni-qt:i386

# install Y PPA Manager
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:webupd8team/y-ppa-manager
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  y-ppa-manager

# libdvdcss2, to play encrypted DVDs
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install libdvdcss2
sudo /usr/share/doc/libdvdread4/./install-css.sh



###############################################################################################
#     WEBBROWSER SOFTWARE SECTION                                                             #
###############################################################################################



if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
# install dolphin (Nintendo Wii emulator)
# requires: Core i5 or Core i7 CPU and DirectX 11 videocard
# cd /tmp
# sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install libsdl2-2.0-0
# rm *.html
# wget https://dolphin-emu.org/download/
# wget `grep deb index.html |head -n 1|cut -d"\"" -f4`
# sudo dpkg -i dolphin*.deb
  
  
# install Google Chrome browser which includes newest version of Adobe Flash - other browsers do not
cd $HOME
wget --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
# fix the Google Chrome dependencies issue
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install YouTubeToMP3 - Youtube playlist downloader
cd $HOME
VIDEODOWNLOADERREMOTEDIR="http://www.mediahuman.com/download.html"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*ube[^"]*amd64*\.deb\)".*/\1/p' | sort -r | head -1) 
url=`echo $url |cut -f2 -d"/"`
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
VIDEODOWNLOADERREMOTEDIR="http://www.mediahuman.com/download/"
wget $VIDEODOWNLOADERREMOTEDIR`echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd $HOME
rm -rf "$dir"
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install 4kvideodownloader that converts personal Youtube playlists to Youtube mp3s
cd $HOME
VIDEODOWNLOADERREMOTEDIR="http://downloads.4kdownload.com/app/"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*videodownloader[^"]*amd64*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget $VIDEODOWNLOADERREMOTEDIR`echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd $HOME
rm -rf "$dir"
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install Google Earth in Ubuntu 13.10 64-bit or newer
#     uninstall old Google Earth
cd $HOME
rm -rf $HOME/.googleearth
sudo rm -rf /opt/google-earth && sudo rm /usr/share/mime/application/vnd.google-earth.* /usr/share/mimelnk/application/vnd.google-earth.* /usr/share/applnk/Google-googleearth.desktop /usr/share/mime/packages/googleearth-mimetypes.xml /usr/share/gnome/apps/Google-googleearth.desktop /usr/share/applications/Google-googleearth.desktop /usr/local/bin/googleearth
sudo rm googleearth*.deb
sudo rm google-earth*.deb
sudo rm GoogleEarth*
sudo dpkg -P google-earth
sudo dpkg -P googleearth
#     install new Google Earth
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  libfreeimage3 lib32nss-mdns multiarch-support lsb-core googleearth-package
sudo make-googleearth-package --force
sudo dpkg -i googleearth*.deb 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install


# install newest wine version 
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes --force-yes -f ppa:ubuntu-wine/ppa 
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge wine wine1.4 wine1.5 wine1.6 winetricks
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f  install wine1.7 winetricks

# install Teamviewer server + client which depends on wine1.7
cd /tmp
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge  teamviewer9
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge  teamviewer8
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge  teamviewer
sudo rm -rf /opt/teamviewer*
rm *.deb
wget --no-check-certificate https://www.teamviewer.com/en/download/linux.aspx
wget `grep deb linux.aspx |grep i386|cut -d"\"" -f6`
sudo dpkg -i teamviewer*.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
# teamviewer autostart fix procedure - add configuration lines below to /etc/rc.local
sudo -k teamviewer --daemon start
cd /opt/teamviewer/tv_bin/script
sudo cp teamviewerd.sysv /etc/init.d/
sudo chmod 755 /etc/init.d/teamviewerd.sysv
sudo update-rc.d teamviewerd.sysv defaults
# !!!!!! Also add teamviewer program to KDE's Autostart (autostart launch command to use: teamviewer)



# install dupeguru-me which can find and delete similar music filenames using fuzzy logic
# rerun dupeguru-me on /media/IOMEGA/downloads/Youtube-playlists  after each mp3 conversion using YouTubeToMP3

# install Viber program
cd $HOME
wget download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo dpkg -i viber.deb 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install


else
  # 32-bit stuff here
  
# install dupeguru-me which can find and delete similar music filenames using fuzzy logic
# rerun dupeguru-me on /media/IOMEGA/downloads/Youtube-playlists  after each mp3 conversion using YouTubeToMP3

# install Google Chrome browser which has better support for Flash websites (Youtube, ...)
cd $HOME
wget --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
sudo dpkg -i google-chrome*.deb
# fix the Google Chrome dependencies issue
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install YouTubeToMP3 - Youtube playlist downloader
cd $HOME
VIDEODOWNLOADERREMOTEDIR="http://www.mediahuman.com/download.html"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*ube[^"]*i386*\.deb\)".*/\1/p' | sort -r | head -1) 
url=`echo $url |cut -f2 -d"/"`
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
VIDEODOWNLOADERREMOTEDIR="http://www.mediahuman.com/download/"
wget $VIDEODOWNLOADERREMOTEDIR`echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd $HOME
rm -rf "$dir"
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install 4kvideodownloader that converts personal Youtube playlists to Youtube mp3s
VIDEODOWNLOADERREMOTEDIR="http://downloads.4kdownload.com/app/"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*videodownloader[^"]*i386*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget $VIDEODOWNLOADERREMOTEDIR`echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd $HOME
rm -rf "$dir"
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install Google Earth in Ubuntu 13.10 32-bit or newer
#     uninstall old Google Earth
cd $HOME
rm -rf $HOME/.googleearth
sudo rm -rf /opt/google-earth && sudo rm /usr/share/mime/application/vnd.google-earth.* /usr/share/mimelnk/application/vnd.google-earth.* /usr/share/applnk/Google-googleearth.desktop /usr/share/mime/packages/googleearth-mimetypes.xml /usr/share/gnome/apps/Google-googleearth.desktop /usr/share/applications/Google-googleearth.desktop /usr/local/bin/googleearth
sudo rm googleearth*.deb
sudo rm google-earth*.deb
sudo rm GoogleEarth*
sudo dpkg -P google-earth
sudo dpkg -P googleearth
#     install new Google Earth
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  libfreeimage3 lib32nss-mdns multiarch-support lsb-core googleearth-package
sudo make-googleearth-package --force
sudo dpkg -i googleearth*.deb 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install newest wine version 
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes --force-yes -f ppa:ubuntu-wine/ppa 
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install wine1.6-i386
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install wine1.6 winetricks

# install Teamviewer server + client which depends on wine1.7
cd /tmp
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge  teamviewer9
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge  teamviewer8
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes purge  teamviewer
sudo rm -rf /opt/teamviewer*
rm *.deb
wget --no-check-certificate https://www.teamviewer.com/en/download/linux.aspx
wget `grep deb linux.aspx |grep i386|cut -d"\"" -f6`
sudo dpkg -i teamviewer*.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
# teamviewer autostart fix procedure - add configuration lines below to /etc/rc.local
sudo -k teamviewer --daemon start
cd /opt/teamviewer/tv_bin/script
sudo cp teamviewerd.sysv /etc/init.d/
sudo chmod 755 /etc/init.d/teamviewerd.sysv
sudo update-rc.d teamviewerd.sysv defaults
# !!!!!! Also add teamviewer program to KDE's Autostart (autostart launch command to use: teamviewer)

fi

# install Opera browser
# wget -O- http://deb.opera.com/archive.key | sudo DEBIAN_FRONTEND=noninteractive apt-key add -
#sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
# sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install opera

# Enable and upgrade the open-source graphics drivers for Intel, AMD Radeon, and Nouveau (NVIDIA)
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes --force-yes -f ppa:oibaf/graphics-drivers
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f dist-upgrade

# OBSOLETE - install Multimedia codecs
# sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo DEBIAN_FRONTEND=noninteractive apt-get --quiet update && sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo DEBIAN_FRONTEND=noninteractive apt-get --quiet update
# sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install non-free-codecs libdvdcss

# install Realplayer (latest version is from 2009)
#sudo DEBIAN_FRONTEND=noninteractive apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install lsb
#wget http://client-software.real.com/free/unix/RealPlayer11GOLD.deb
#sudo dpkg -i RealPlayer11GOLD.deb

# uninstall Java due to all the critical security issues in 2013
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove java-common
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove default-jre
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove default-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove gcj-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove openjdk-6-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove openjdk-7-jre-headless

#sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes remove mysql-server-core-?.?
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  remove unity-lens-music unity-lens-photos unity-lens-shopping unity-lens-video
# sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge pulseaudio*
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge arno-iptables-firewall
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge ufw
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge  xscreensaver  xscreensaver-data gnome-screensaver
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge evolution-data-server-common samba
sudo DEBIAN_FRONTEND=noninteractive apt-get autoclean
sudo DEBIAN_FRONTEND=noninteractive apt-get clean

# install multisystem tool (best multiboot USB stick creator for Ubuntu):
# procedure:  http://community.linuxmint.com/tutorial/view/1219
# Use axel command line utility to download all the .iso images into the /tmp directory
# then import each .iso image file one by one into multisystem
# multisystem can successfully boot Linux Mint, Knoppix (4GB edition), 
# System Rescue CD and Hiren Boot CD from the same USB stick
# multisystem seems to work better than YUMI, because multisystem can successfully boot
# Knoppix (4GB edition) but YUMI could not, when having multiple iso images on the same USB stick
wget http://liveusb.info/multisystem/install-depot-multisystem.sh.tar.bz2
unp install-depot-multisystem.sh.tar.bz2
./install-depot-multisystem.sh
rm *.sh
rm *.html

# Install yEd graph editor (includes BPMN icons) (Business Process Modeling Notation (BPMN) diagram creation tool))
# (powerful desktop application that can be used to quickly and effectively generate high-quality diagrams)
# Save diagrams in .pdf format so they can be included as graphics in a new latex document in texmaker
# Allows easy creation of Entity Relationship (ER) diagrams (as part of data modeling by data scientist)
# documentation:  http://www.linuxuser.co.uk/tutorials/create-flowcharts-with-yedcreate-flowcharts-with-yed
# other BPMN tools: https://en.wikipedia.org/wiki/Comparison_of_Business_Process_Modeling_Notation_tools
MACHINE_TYPE=`uname -m`

cd /tmp
rm *.sh
rm *.html

if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
wget http://www.yworks.com/en/products_yed_download.html
YEDVERSION=`cat products_yed_download.html |grep Download|grep yEd|cut -d" " -f3|cut -d"<" -f1`
wget http://live.yworks.com/yed-downloads/yEd-`echo $YEDVERSION`_64-bit_setup.sh
sh yEd-`echo $YEDVERSION`_64-bit_setup.sh

else
  # 32-bit stuff here
wget http://www.yworks.com/en/products_yed_download.html
YEDVERSION=`cat products_yed_download.html |grep Download|grep yEd|cut -d" " -f3|cut -d"<" -f1`
wget http://live.yworks.com/yed-downloads/yEd-`echo $YEDVERSION`_32-bit_setup.sh
sh yEd-`echo $YEDVERSION`_32-bit_setup.sh

fi

# install Kruidvat fotoservice software
cd $HOME
wget http://dls.photoprintit.com/download/Data/1287/hps/setup_Kruidvat_fotoservice.tgz
tar -zxvf setup_Kruidvat_fotoservice.tgz 
./install.pl 

# set fish shell as default shell
chsh -s /usr/bin/fish
#To switch your default shell back, you can run:
#chsh -s /bin/bash
cd $HOME
# customize fish shell using oh-my-fish
mkdir ~/.config/fish/
rm -rf ~/.oh-my-fish
git clone git://github.com/bpinto/oh-my-fish.git ~/.oh-my-fish
cp ~/.oh-my-fish/templates/config.fish ~/.config/fish/config.fish

# delete old custom aliases in ~/.config/fish/config.fish file
egrep -v 'alias\ apt|alias\ d-u'  ~/.config/fish/config.fish > ~/.config/fish/config.fishBACKUP
cp ~/.config/fish/config.fishBACKUP ~/.config/fish/config.fish

# define custom aliases in ~/.config/fish/config.fish file
echo "alias apti='sudo aptitude update ; sudo aptitude install '" >> ~/.config/fish/config.fish
echo "alias aptr='sudo aptitude remove '" >> ~/.config/fish/config.fish
echo "alias aptp='sudo aptitude purge '" >> ~/.config/fish/config.fish
echo "alias aptu='sudo aptitude update'" >> ~/.config/fish/config.fish
echo "alias apts='sudo aptitude search '" >> ~/.config/fish/config.fish
echo "alias d-u='sudo aptitude update ; sudo aptitude dist-upgrade'" >> ~/.config/fish/config.fish

# run shellshock test to see if bash is vulnerable
cd $HOME
rm *.sh
wget https://shellshocker.net/shellshock_test.sh ; bash shellshock_test.sh

# clean up current directory
echo "Performing file cleanup"
cd $HOME
mv *.deb $DEB
rm *.exe
mv *.km? $KMZ
mv *.pdf $PDF
mv *gz $TAR
mv *.zip $ZIP
rm *.cab
rm *.crt
rm .goutputstrea*
rm *.html
rm *.sh
rm *.xpi
rm ica_*
rm google*

###############################################################################################
#     ASTRONOMY SOFTWARE SECTION                                                              #
###############################################################################################

# install zotero add-on for Mozilla Firefox
#cd $HOME
#wget https://download.zotero.org/extension/zotero-4.0.20.2.xpi
#gksudo firefox -install-global-extension zotero-4.0.20.2.xpi

cd $HOME/shell-scripts
sudo DEBIAN_FRONTEND=noninteractive aptitude install `cat astropackages` -o APT::Install-Suggests="false"
cd $HOME

# install texlive 2012.201206 packages (will upgrade texlive 2009 to texlive 2012.201206 in Ubuntu 12.04)
# sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes ppa:texlive-backports/ppa
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  texlive-latex-extra texlive-bibtex-extra latex-xcolor biber
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  texlive-fonts-recommended texlive-binaries texlive-latex-base texlive-publishers
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  texlive-latex-extra biblatex

# install casapy-upstream-binary  - Common Astronomy Software Applications package provided by NRAO, python bindings
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes --force-yes  ppa:aims/casapy
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install casapy-upstream-binary

sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes --force-yes  ppa:olebole/astro-quantal
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install casacore 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install cpl
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install esorex
# download and decompress SAOImage DS9 software
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install saods9 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install sextractor 


# download CSC KML Interface to Sky in Google Earth
echo "Downloading CSC KML Interface to Sky in Google Earth"
wget http://cxc.harvard.edu/csc/googlecat/cxo_1.2.kml
echo "kml file can be opened using Google Earth"

# download The Crab Nebula Explodes
echo "Downloading The Crab Nebula Explodes"
wget http://services.google.com/earth/kmz/crab_nebula_n.kmz
echo "kmz file can be opened using Google Earth"

# download Multicolor Galaxies
echo "Downloading Multicolor Galaxies"
wget http://services.google.com/earth/kmz/aegis_n.kmz
echo "kmz file can be opened using Google Earth"

# download Images of Nearby Galaxies from the National Optical Astronomical Observatory
echo "Downloading Images of Nearby Galaxies from the National Optical Astronomical Observatory"
wget http://services.google.com/earth/kmz/noao_showcase_n.kmz
echo "kmz file can be opened using Google Earth"

# download The Sloan Digital Sky Survey catalog
echo "Downloading The Sloan Digital Sky Survey catalog"
wget http://services.google.com/earth/kmz/sdss_query_n.kmz
echo "kmz file can be opened using Google Earth"

# download Exoplanets
echo "Downloading Exoplanets"
wget http://services.google.com/earth/kmz/exo_planets_n.kmz
echo "kmz file can be opened using Google Earth"



# download and install Audela
echo "Downloading and installing Audela - free and open source astronomy software intended for digital observations"
wget http://sourceforge.net/projects/audela/files/audela/`echo $AUDELAFILENAME`/`echo $AUDELAFILENAME`.deb
sudo dpkg -i  `echo $AUDELAFILENAME`.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
# download and decompress IRAF - Image Reduction and Analysis Facility, a general purpose
# software system for the reduction and analysis of astronomical data
#echo "Downloading and decompressing IRAF - Image Reduction and Analysis Facility"
#wget ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86_64.tar.gz
#unp iraf.lnux.x86_64.tar.gz

#echo "Downloading and installing skychart"
#SKYCHARTREMOTEDIR="http://sourceforge.net/projects/skychart/files/1-%20cdc-skychart/version_3.8/"
#url=$(wget -O- -q --no-check-certificate `echo $SKYCHARTREMOTEDIR` |  sed -ne 's/^.*"\([^"]*skychart[^"]*amd64*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
#dir=$(mktemp -dt)
#cd "$dir"
# Download the .deb file
#wget `echo $SKYCHARTREMOTEDIR``echo $url`
# Install the package
#sudo dpkg -i $url
# Clean up
#rm $url
#cd $HOME
#rm -rf "$dir"
#cd $HOME
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  texmaker
#install texstudio
#TEXSTUDIOREMOTEDIR="http://download.opensuse.org/repositories/home:/jsundermeyer/xUbuntu_13.10/amd64/"
#url=$(wget -O- -q --no-check-certificate `echo $TEXSTUDIOREMOTEDIR` |  sed -ne 's/^.*"\([^"]*texstudio[^"]*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
#dir=$(mktemp -dt)
#cd "$dir"
# Download the .deb file
#wget `echo $TEXSTUDIOREMOTEDIR``echo $url`
# Install the package
#sudo dpkg -i `echo $url`
# Clean up
#rm `echo $url`
#cd
#rm -rf "$dir"
#cd
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

else
  # 32-bit stuff here
# download and decompress IRAF - Image Reduction and Analysis Facility, a general purpose
# software system for the reduction and analysis of astronomical data
#echo "Downloading and decompressing IRAF - Image Reduction and Analysis Facility"
#wget ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86.tar.gz
#unp iraf.lnux.x86.tar.gz

#echo "Downloading and installing skychart"
#SKYCHARTREMOTEDIR="http://sourceforge.net/projects/skychart/files/1-%20cdc-skychart/version_3.8/"
#url=$(wget -O- -q --no-check-certificate `echo $SKYCHARTREMOTEDIR` |  sed -ne 's/^.*"\([^"]*skychart[^"]*i386*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
#dir=$(mktemp -dt)
#cd "$dir"
# Download the .deb file
#wget `echo $SKYCHARTREMOTEDIR``echo $url`
# Install the package
#sudo dpkg -i $url
# Clean up
#rm $url
#cd $HOME
#rm -rf "$dir"
#cd $HOME
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install   texmaker
#install texstudio
#TEXSTUDIOREMOTEDIR="http://download.opensuse.org/repositories/home:/jsundermeyer/xUbuntu_12.10/i386/"
#url=$(wget -O- -q --no-check-certificate `echo $TEXSTUDIOREMOTEDIR` |  sed -ne 's/^.*"\([^"]*texstudio[^"]*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
#dir=$(mktemp -dt)
#cd "$dir"
# Download the .deb file
#wget `echo $TEXSTUDIOREMOTEDIR``echo $url`
# Install the package
#sudo dpkg -i `echo $url`
# Clean up
#rm `echo $url`
#cd
#rm -rf "$dir"
#cd
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

fi

#wget http://sourceforge.net/projects/skychart/files/2-catalogs/Stars/skychart-data-stars_3.8-2293_all.deb
#sudo dpkg -i skychart-data-stars_3.8-2293_all.deb
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

#wget http://sourceforge.net/projects/skychart/files/2-catalogs/Nebulea/skychart-data-dso_3.8-2293_all.deb
#sudo dpkg -i skychart-data-dso_3.8-2293_all.deb
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

#wget http://sourceforge.net/projects/skychart/files/2-catalogs/Nebulea/skychart-data-pictures_3.1-1466_all.deb
#sudo dpkg -i skychart-data-pictures_3.1-1466_all.deb
#sudo DEBIAN_FRONTEND=noninteractive apt-get -f install


###############################################################################################
#     DOWNLOAD TRIATLAS PDF FILES BEFORE ANY OTHER PDF FILES                                  #
###############################################################################################
# clean up current directory
echo "Performing file cleanup"
cd $HOME
mv *.deb $DEB
rm *.exe
mv *.km? $KMZ
mv *.pdf $PDF
mv *gz $TAR
mv *.zip $ZIP
rm *.cab
rm *.crt
rm .goutputstrea*
rm *.html
rm *.sh
rm *.xpi
rm ica_*
rm google*


#download Triatlas charts in PDF format from http://www.uv.es/jrtorres/triatlas.html
echo "Downloading Triatlas charts (from jrtorres) in A4 format for Europe"
wget http://www.uv.es/jrtorres/section_a/Triatlas_2ed_A.pdf
wget http://www.uv.es/jrtorres/TriAtlas_A_Index.pdf
wget http://www.uv.es/jrtorres/section_b/Triatlas_2ed_B1.pdf
wget http://www.uv.es/jrtorres/section_b/Triatlas_2ed_B2.pdf
wget http://www.uv.es/jrtorres/section_b/Triatlas_2ed_B3.pdf
wget http://www.uv.es/jrtorres/TriAtlas_B_Index.pdf
wget http://www.uv.es/jrtorres/section_c/C01_001-030.pdf
wget http://www.uv.es/jrtorres/section_c/C02_031-060.pdf
wget http://www.uv.es/jrtorres/section_c/C03_061-090.pdf
wget http://www.uv.es/jrtorres/section_c/C04_091-120.pdf
wget http://www.uv.es/jrtorres/section_c/C05_121-150.pdf
wget http://www.uv.es/jrtorres/section_c/C06_151-180.pdf
wget http://www.uv.es/jrtorres/section_c/C07_181-210.pdf
wget http://www.uv.es/jrtorres/section_c/C08_211-240.pdf
wget http://www.uv.es/jrtorres/section_c/C09_241-270.pdf
wget http://www.uv.es/jrtorres/section_c/C10_271-300.pdf
wget http://www.uv.es/jrtorres/section_c/C11_301-330.pdf
wget http://www.uv.es/jrtorres/section_c/C12_331-360.pdf
wget http://www.uv.es/jrtorres/section_c/C13_361-390.pdf
wget http://www.uv.es/jrtorres/section_c/C14_391-420.pdf
wget http://www.uv.es/jrtorres/section_c/C15_421-450.pdf
wget http://www.uv.es/jrtorres/section_c/C16_451-480.pdf
wget http://www.uv.es/jrtorres/section_c/C17_481-510.pdf
wget http://www.uv.es/jrtorres/section_c/C18_511-540.pdf
wget http://www.uv.es/jrtorres/section_c/C19_541-571.pdf
wget http://www.uv.es/jrtorres/TriAtlas_C_Index.pdf
mv *.pdf triatlas

# download SAO/NASA ADS Help Pages
echo "Downloading SAO/NASA ADS Help Pages"
wget http://adsabs.harvard.edu/abs_doc/help_pages/adshelp.pdf
mv adshelp.pdf sao_nasa_ads_help_pages_July_9_2012.pdf

# download American Astronomical Society manuscript preparation guidelines 
echo "Downloading American Astronomical Society manuscript preparation guidelines"
wget http://ctan.mackichan.com/macros/latex/contrib/aastex/docs/aasguide.pdf
mv aasguide.pdf American_Astronomical_Society_guidelines.pdf

# download The Not So Short Introduction to LaTeX2e by Tobias Oetiker et alii
echo "Downloading The Not So Short Introduction to LaTeX2e by Tobias Oetiker et alii"
wget http://tobi.oetiker.ch/lshort/lshort.pdf
mv lshort.pdf latex2-not-so-short-introduction.pdf

wget http://kelder.zeus.ugent.be/~gaspard/latex/latex-cursus.pdf

wget http://latex-project.org/guides/lc2fr-apb.pdf
mv lc2fr-apb.pdf‎detecting-solving-latex-issues.pdf

echo "Downloading Springer monograph template"
wget http://www.springer.com/cda/content/document/cda_downloaddocument/manuscript-guidelines-1.0.pdf
mv manuscript-guidelines-1.0.pdf Springer-book-manuscript-guidelines-1.0.pdf
wget http://www.springer.com/cda/content/document/cda_downloaddocument/Key_Style_Points_1.0.pdf
mv Key_Style_Points_1.0.pdf Springer-book-Key_Style_Points_1.0.pdf
wget http://www.springer.com/cda/content/document/cda_downloaddocument/svmono.zip
mv svmono.zip Springer-svmono-monograph-Latex-template.zip

echo "Downloading awesome professional looking Legrand Orange Book template"
wget http://www.latextemplates.com/templates/books/2/book_2.zip
mv book_2.zip Legrand_Orange_Book_template_book_2_excellent.zip

# clean up current directory
echo "Performing file cleanup"
cd $HOME
mv *.deb $DEB
rm *.exe
mv *.km? $KMZ
mv *.pdf $PDF
mv *gz $TAR
mv *.zip $ZIP
rm *.cab
rm *.crt
rm .goutputstrea*
rm *.html
rm *.sh
rm *.xpi
rm ica_*
rm google*

# uninstall Java due to all the critical security issues in 2013
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove java-common
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove default-jre
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove gcj-?.?-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove openjdk-?-jre-headless
#sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes remove mysql-server-core-?.?
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  remove unity-lens-music unity-lens-photos unity-lens-shopping unity-lens-video
# sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge pulseaudio*
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge arno-iptables-firewall
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge ufw
sudo DEBIAN_FRONTEND=noninteractive apt-get autoclean
sudo DEBIAN_FRONTEND=noninteractive apt-get clean
sudo rm /etc/apt/sources.list.d/*
#grep -v opera /etc/apt/sources.list  > /tmp/sources.list
#sudo cp /tmp/sources.list  /etc/apt/sources.list

# wget http://hea-www.harvard.edu/simx/simx-2.0.6.tar.gz
# tar -zxvf simx-2.0.6.tar.gz
# cd simx-2.0.6/
# sudo ./configure
# sudo make
# sudo make install
# cd ..
# compile fails with error configure: error: Problem with readline; run 
#  configure --help and see --with-readline option


# download and decompress Digital Universe and Partiview Resources
echo "Downloading and decompressing Digital Universe and Partiview Resources"
cd $HOME
rm *.tgz
rm DU*
rm download-files
wget http://www.amnh.org/our-research/hayden-planetarium/hayden-planetarium-promos/download-files
wget `cat download-files |grep linux|grep undle|cut -d"\"" -f2`
FILENAME=`cat download-files |grep linux|grep undle|cut -d"\"" -f2|cut -d"/" -f7`
unp $FILENAME


# download and decompress Nightshade 
# Nightshade is free, open source astronomy simulation and visualization software for teaching and exploring astronomy
#echo "Downloading and decompressing Nightshade"
# install libfastdb first, because nightshade depends on it
#cd $HOME
#rm *.html
#rm *.tar.gz
#rm -rf nightshade*
#rm files
#rm Nightshade*.exe
#wget http://www.garret.ru/fastdb.html
#wget `cat fastdb.html |grep nix|cut -d"\"" -f2`
#unp fastdb*.tar.gz
#cd fastdb*
#sudo ./configure
#sudo make
#sudo make install
#sudo ldconfig

# install SDL_Pango first, because nightshade depends on it
# but nightshade cannot find SDL_Pango library, even after installing it
#cd $HOME
#rm *.html
#wget http://downloads.sourceforge.net/project/sdlpango/SDL_Pango/0.1.2/SDL_Pango-0.1.2.tar.gz
#unp SDL_Pango-0.1.2.tar.gz
#cd SDL_Pango*
#sudo ./configure
#sudo make
#sudo make install
#sudo ldconfig

cd $HOME
rm files
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install libgraphicsmagick++1-dev libsdl1.2-dev
#wget http://www.nightshadesoftware.org/projects/nightshade/files
#wget http://www.nightshadesoftware.org`cat files|grep win32|cut -d"\"" -f4`
#FILENAME=`cat files|grep win32|cut -d"\"" -f4|cut -d"/" -f5`
#wine $FILENAME
# this Windows version of Nightshade requires a videocard that supports OpenGL 3.0 or higher

# download and decompress scisoft utilities
# source: http://navtejblog.blogspot.be/2014/05/installing-eso-scisoft-on-ubuntu-1404.html
echo "Downloading and decompressing scisoft utilities"
wget ftp://ftp.eso.org/scisoft/scisoft`echo $SCISOFTFILENAME`/linux/fedora11/tar/scisoft-`echo $SCISOFTFILENAME`.tar.gz
unp scisoft-`echo $SCISOFTFILENAME`.tar.gz
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install tcsh:i386 libgfortran3:i386 libreadline5:i386 libsdl-image1.2:i386 libsdl-ttf2.0-0:i386 unixodbc:i386
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install libxft2:i386 libxrandr2:i386 libxmu6:i386 libXss1:i386  libXtst6:i386  libcanberra-gtk3-module:i386

# download and compile skyviewer from http://lambda.gsfc.nasa.gov/toolbox/tb_skyviewer_ov.cfm
# installation procedure updated on November 30, 2014
cd $HOME
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install unp  libqglviewer-dev  libcfitsio3-dev qt4-dev-tools libglu1-mesa  libglu1-mesa-dev
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install libchealpix0  libchealpix-dev
wget http://mirrors.kernel.org/ubuntu/pool/universe/c/chealpix/libchealpix0_3.11.4-2_amd64.deb
sudo dpkg -i libchealpix0_3.11.4-2_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/c/chealpix/libchealpix-dev_3.11.4-2_amd64.deb
sudo dpkg -i libchealpix-dev_3.11.4-2_amd64.deb
wget http://lambda.gsfc.nasa.gov/toolbox/tb_skyviewer_ov.cfm
FILENAME=`grep Version tb_skyviewer_ov.cfm |grep kyviewer|cut -d"\"" -f2|cut -d"/" -f2|head -n1`
wget http://lambda.gsfc.nasa.gov/toolbox/skyviewer/$FILENAME
unp $FILENAME
cd skyviewer*
qmake
echo "LIBS = -L/usr/lib/x86_64-linux-gnu -L/usr/X11R6/lib64 -lcfitsio -lQGLViewer -lchealpix -L/usr/local/lib -lpthread -lQtXml -lQtOpenGL -lQtGui -lQtCore -lGL -lGLU" >> Makefile
make
cd $HOME
rm tb_skyviewer_ov.cfm

# download C2A Planetarium Software for Windows platform
echo "Downloading C2A Planetarium Software for Windows platform - use wine application"
wget http://www.astrosurf.com/c2a/english/download/`echo $C2AFILENAME`
unp `echo $C2AFILENAME`
wine setup.exe




# install texlive the only proper way so that tlmgr also works correctly in Ubuntu 13.10 or Ubuntu 14.04 LTS
# procedure created on March 8, 2014:
# install-tl-ubuntu script requires 4GB of free diskspace

#sudo DEBIAN_FRONTEND=noninteractive apt-get purge texlive-base texlive-binaries  texlive-fonts-recommended
#sudo DEBIAN_FRONTEND=noninteractive apt-get purge  texlive-common texlive-doc-base texlive-latex-base texlive-publishers
sudo DEBIAN_FRONTEND=noninteractive apt-get install texlive-fonts-recommended
git clone https://github.com/scottkosty/install-tl-ubuntu.git
cd install-tl-ubuntu
./install-tl-ubuntu --help

# following script tries to install Ubuntu package parallel which ONLY exists in Ubuntu 13.10 and Ubuntu 14.04 LTS
sudo bash install-tl-ubuntu  --allow-small

sudo texhash
tlmgr init-usertree
tlmgr update --all
tlmgr install hyperref
sudo fmtutil-sys --all
sudo update-texmf

# install R 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  r-base-core r-base

# install rstudio / R-Studio :
# Free disk space required: around 5 GB
# Mac OS X users should use RStudio-0.98.501.dmg instead of R to avoid the following UNIX child process forking error:
# THE_PROCESS_HAS_FORKED_AND_YOU_CANNOT_USE_THIS_COREFOUNDATION_FUNCTIONALITY_YOU_MUST_EXEC__() to debug.

MACHINE_TYPE=`uname -m`

cd /tmp
rm rstudio*.deb
rm index.html

if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here

sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install gdebi-core pandoc libssl0.9.8 libapparmor1
wget http://www.rstudio.com/products/rstudio/download/
wget `cat index.html|grep -v tar|grep amd64\.deb|cut -d"\"" -f2`
sudo dpkg -i rstudio*.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

else
  # 32-bit stuff here
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install gdebi-core pandoc libssl0.9.8 libapparmor1
wget http://www.rstudio.com/products/rstudio/download/
wget `cat index.html|grep -v tar|grep i386\.deb|cut -d"\"" -f2`
sudo dpkg -i rstudio*.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

fi

cd $HOME

# troubleshooting information to check the rstudio installation:
file /usr/lib/rstudio/bin/rstudio
ldd `which rstudio`

# install texmaker and knitr (used by texmaker) from source code:
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes texinfo texmaker r-base-core r-base
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes texlive-fonts-extra unp

# install testit and rgl packages which are prerequisites
# for the make check command below:
cd
rm -rf testit*
git clone https://github.com/yihui/testit.git
R CMD build testit
R CMD INSTALL testit_*.tar.gz

cd /tmp
rm index.html
wget http://cran.r-project.org/src/contrib/
FILENAME=`grep \"rgl index.html |head -n 1|cut -d"\"" -f8`
wget http://cran.r-project.org/src/contrib/`echo $FILENAME`
unp rgl*
R CMD build rgl
R CMD INSTALL rgl_*.tar.gz

# install knitr 1.9.3:
cd
rm -rf knit*
git clone https://github.com/yihui/knitr.git
R CMD build knitr
R CMD INSTALL knitr_*.tar.gz
sudo cp ~/knitr/inst/bin/knit /usr/bin/knit
cd knitr
make check

cd
rm -rf knitr-examples*
git clone https://github.com/yihui/knitr-examples

# clean up current directory
echo "Performing file cleanup"
cd $HOME
mv *.deb $DEB
rm *.exe
mv *.km? $KMZ
mv *.pdf $PDF
mv *gz $TAR
mv *.zip $ZIP
rm *.cab
rm *.crt
rm .goutputstrea*
rm *.html
rm *.sh
rm *.xpi
rm ica_*
rm google*
sudo rm /etc/apt/sources.list.d/*


# install weka v3.7.11 - import preprocessed .csv from R into weka to perform significant
# feature/variable selection for R models
#cd $HOME
#wget http://prdownloads.sourceforge.net/weka/`echo $WEKAFILENAME`
#unzip `echo $WEKAFILENAME`

# following URL added on September 20, 2014:
# install Google Cloud SDK (to be able to use Big Query)
curl https://sdk.cloud.google.com | bash


###############################################################################################
#     Links for astronomers                                                                   #
###############################################################################################

echo "Please add these Astronomy bookmarks into all 5 webbrowsers (chromium, firefox, konqueror, chrome, opera)"
echo "http://www.gmail.com"
echo "http://arxiv.org/list/astro-ph/new"
# in arxiv.org: click on 'other' next to 'pdf' and choose to 'download source' using the wget command in a Terminal
# to examine the original .tex file which uses the aastex class
# decompress the extensionless source file using  the unp command
# following URL added on December 2, 2014:
echo "http://libgen.org/"
echo "http://adsabs.harvard.edu/abstract_service.html"
# following URL added on February 12, 2014:
# INSPIRE High Energy Physics information system (search engine):
echo "http://inspirehep.net/?ln=en"
# excellent website added to this list on June 7, 2013
echo "http://cdsweb.u-strasbg.fr/"
echo "http://ned.ipac.caltech.edu/"
# excellent website added to this list on June 3, 2013
echo "http://www.usvao.org/"
# excellent website added to this list on June 3, 2013
echo "http://vao.stsci.edu/portal/Mashup/Clients/Portal/DataDiscovery.html"
echo "http://en.wikipedia.org/wiki/List_of_nearest_stars"
echo "http://www.wolframalpha.com/input/?i=astronomy&a=*C.astronomy-_*ExamplePage-"
echo "http://www.worldwidetelescope.org/webclient/"
echo "http://www.skyviewcafe.com/skyview.php"
echo "http://en.wikipedia.org/wiki/Star_catalogue#Successors_to_USNO-A.2C_USNO-B.2C_NOMAD.2C_UCAC_and_Others"
echo "http://www.aanda.org/"
echo "http://www.usno.navy.mil/USNO/astrometry/information/catalog-info/catalog-information-center-1#usnob1"
echo "http://www.usno.navy.mil/USNO/astrometry/optical-IR-prod/icas/fchpix"
echo "http://be.kompass.com/live/fr/w2866018/edition-livres/edition-livres-astronomie-geodesie-meteorologie-1.html#.UV1dCqA9RZc"
# following URL (Open Source Physics project containing Java simulations for astronomy) added on April 23, 2013:
echo "http://www.opensourcephysics.org/search/categories.cfm?t=SimSearch"
# following URL added on April 23, 2013:
echo "http://astro.unl.edu/naap/"
echo "http://en.wikibooks.org/wiki/LaTeX"
# following URL added on April 23, 2013:
echo "http://latex.ugent.be/cursus.php"
# following URL added on April 30, 2013:
echo "http://www.texdoc.net/"
# following URL added on May 13, 2013:
echo "https://github.com/search?q=documentclass+book+astronomy&nwo=pwl%2Fmaster&search_target=global&type=Code&ref=cmdform"
# following URL added on May 14, 2013 - very handy when creating latex document in texstudio:
echo "http://detexify.kirelabs.org/classify.html"
# following URL added on February 11, 2014 - very handy when creating latex document in texstudio:
# create formula in texstudio using handwriting
echo "http://webdemo.visionobjects.com/home.html?locale=fr_FR#equation"
# following URL added on January 15, 2014:
echo "http://www.math.toronto.edu/mathit/symbols-letter.pdf"
# following URL added on May 28, 2013 - very handy when creating latex document in texstudio:
echo "http://www.latextemplates.com/"
echo "http://www.ottobib.com/"
echo "http://scholar.google.be"
# following URL added on April 23, 2013:
echo "http://www.google.com/mars/"
# following URL added on April 23, 2013:
echo "http://www.google.com/moon/"
# following URL added on June 3, 2013:
echo "http://www.redorbit.com/news/space/"
# following URL added on June 4, 2013:
echo "http://www.intechopen.com/search?q=astronomy"
echo "http://www.youtube.com/"
echo "http://www.krantenkoppen.be/"
# following URL added on June 12, 2013:
echo "http://www.krantenkoppen.be/?rub=koppen&cat=wetenschap&taal=EN"
# following URL added on June 12, 2013:
echo "http://www.krantenkoppen.be/?rub=koppen&cat=wetenschap&taal=NL"
echo "http://www.economist.com/"
echo "http://www.wired.com/"
# following URL added on September 26, 2013:
echo "http://www.nytimes.com/"
# following URL added on June 12, 2013:
echo "http://aer.aas.org/"
# following URL added on June 12, 2013:
echo "http://www.doaj.org/doaj?func=subject&cpId=56&uiLanguage=en"
# following URL added on June 12, 2013:
echo "http://www.hindawi.com/journals/aa/contents/"
# following URL added on June 12, 2013:
echo "http://journals.cambridge.org/action/advanceSearch?jid=PAS&sessionId=70EB679458B99DAEDCA3807566C4DCEC.journals"
echo "http://heasarc.gsfc.nasa.gov/docs/heasarc/astro-update/"
# following URL added on June 4, 2013:
echo "http://svs.gsfc.nasa.gov/"
echo "http://mipav.cit.nih.gov/download.php"
echo "http://www.amazon.com"
echo "https://help.ubuntu.com/community/ExternalGuides"
# following URL added on June 15, 2013:
echo "http://www.verkeerscentrum.be/"
# following URL added on June 15, 2013:
echo "http://offshoreleaks.icij.org/"
# following URL added on June 15, 2013:
echo "http://hubblesite.org/"
# following URL added on June 17, 2013:
echo "http://www.newscientist.com/section/space"
# following URL added on June 18, 2013:
echo "http://www.bbc.co.uk/science/space/"
# following URL added on June 26, 2013:
echo "http://www.eso.org/sci/php/libraries/latest-eso-papers.html"
# following URL added on June 27, 2013:
echo "http://www.googleguide.com/advanced_operators_reference.html"
# following URL added on June 28, 2013:
echo "http://spectrum.ieee.org/aerospace/astrophysics"
# following URL added on July 1, 2013:
# info about proper motion of L 726-8 A = “V* BL Cet -- Flare Star” = Luyten 726-8 A
echo "http://simbad.u-strasbg.fr/simbad/sim-basic?Ident=L+726-8+A&submit=SIMBAD+search"
# following URL added on July 1, 2013:
echo "http://science.nasa.gov/science-news/"
# following URL added on July 1, 2013:
echo "http://news.discovery.com/space/tags/astrophysics.htm"
# following URL added on July 1, 2013:
echo "http://www.oalib.com/"
# following URL added on July 5, 2013:
echo "http://www.ncbi.nlm.nih.gov/pmc/"
# following URL added on July 10, 2013:
echo "http://www.capjournal.org/issues/"
# following URL added on July 11, 2013:
echo "http://www.nature.com/nature/archive/subject.html?code=34"
# following URL added on July 11, 2013:
echo "http://www.spacetelescope.org/news/"
# following URL added on July 16, 2013:
echo "http://interestingengineering.com/"
# open-source data analytics / data mining application for Ubuntu - added on July 19, 2013:
echo "http://orange.biolab.si/"
# following URL added on October 18, 2013:
echo "http://www.space.com/"
# following URL added on October 30, 2013:
echo "https://github.com/hannorein/open_exoplanet_catalogue/"
# following URL added on October 30, 2013:
echo "http://www.dlr.de/dlr/en/desktopdefault.aspx/tabid-10079/"
# following URL added on October 30, 2013:
echo "http://7timer.y234.cn/"
# following URL added on November 15, 2013:
echo "http://news.sciencemag.org/category/space"
# following URL added on November 18, 2013:
# PPMXL catalog contains largest list of proper motions for 900 million objects
echo "http://dc.zah.uni-heidelberg.de/ppmxl/q/cone/form"
# following URL added on November 19, 2013:
# PPMXL catalog contains largest list of proper motions for 900 million objects
echo "http://vizier.u-strasbg.fr/viz-bin/VizieR?-source=%20PPMXL"
# following URL added on December 9, 2013:
echo "http://www.pnas.org/content/by/section/Astronomy"

# following URL added on January 25, 2014:
echo "http://science.time.com/category/space-2/"
# following URL added on February 5, 2014:
# Big Data algorithms and applications from Darpa published on github:
echo "http://www.darpa.mil/OpenCatalog/index.html"
# following URL added on February 7, 2014:
echo "http://video.fosdem.org/"
# following URL added on February 12, 2014:
echo "http://www.astro.ulb.ac.be/pmwiki/IAA/HomePage"
# following URL added on February 12, 2014:
# Linux astronomy distribution based on Ubuntu
echo "http://www.distroastro.org/"
# following URL added on February 12, 2014:
echo "http://www.allesoversterrenkunde.nl/#!/actueel"
# following URL added on February 18, 2014:
echo "http://www.stellarium.org/wiki/index.php/Stellarium_User_Guide"
# following URL added on February 26, 2014:
# OAD Open Data Repositories (including Repositories about Astronomy)
echo "http://oad.simmons.edu/oadwiki/Data_repositories"

###############################################################################################
#     Open access journals                                                                    #
###############################################################################################
# following URL added on February 25, 2014:
echo "http://www.plos.org/publications/journals/"
# following URL added on July 10, 2014:
echo "http://www.springeropen.com/journals"
# following URL added on July 13, 2014:
echo "http://www.gigasciencejournal.com/"

###############################################################################################
#     Anti-NSA measures - PRISM Break anonymizing websites                                                        #
###############################################################################################
# following URL added on June 15, 2013:
echo "http://prism-break.org/"
# following URL added on January 21, 2014:
echo "https://startpage.com/"
# following URL added on June 15, 2013:
echo "http://www.opennicproject.org/nearest-servers/"
# following URL added on March 23, 2014:
echo "https://3.hidemyass.com"

###############################################################################################
#     Math links for kids                                                                     #
###############################################################################################
# following URL added on February 18, 2014:
echo "http://packages.ubuntu.com/saucy/edubuntu-desktop"
# following URL added on February 18, 2014:
echo "http://mathworld.wolfram.com/"
# following URL added on February 12, 2014:
echo "http://nl.wikipedia.org/wiki/Hoofdpagina"
# following URL added on February 19, 2014:
echo "https://fr.khanacademy.org/"
# following URL added on February 10, 2014:
echo "http://um.mendelu.cz/maw-html/index.php?lang=fr"
# following URL added on February 10, 2014:
echo "http://doc.ubuntu-fr.org/logiciels_educatifs_pour_les_enfants"
# following URL added on February 10, 2014:
echo "http://www.pyromaths.org/enligne/"
# following URL added on February 11, 2014 (requires paying for W/A Pro account):
echo "http://www.wolframalpha.com/problem-generator/"
# following URL added on February 11, 2014:
echo "http://symbolab.com/solver"
# following URL added on February 11, 2014:
echo "http://www.grundschulstoff.de/arbeitsblatt-generator/schulfaecher.html"
# following URL added on February 11, 2014:
echo "http://www.mathmaster.org/worksheet/"
# following URL added on February 11, 2014:
echo "http://www.math-aids.com/"
# following URL added on February 11, 2014:
echo "http://www.gomaths.ch/liens_divers.php"
# following URL added on February 11, 2014:
echo "http://www.xm1math.net/"
# following URL added on February 13, 2014:
echo "http://www.aplusclick.com/"
# following URL added on February 18, 2014:
echo "http://opensource.com/education/13/4/guide-open-source-education"
# following URL added on February 21, 2014:
echo "https://www.coursesites.com/webapps/Bb-sites-course-creation-BBLEARN/pages/mooccatalog.html"
# following URL added on March 3, 2014:
echo "https://www.oppia.org/learn"
# following URL added on March 29, 2014:
echo "http://www.mooc-list.com/"

###############################################################################################
#     Language links for kids                                                                     #
###############################################################################################
# following URL added on February 11, 2014:
echo "http://www.lasouris-web.org/lasouris/imprimer.html"
# following URL added on February 11, 2014:
echo "http://www.desmoulins.fr/index.php?pg=scripts!online!scolaire!francais!conjugaison"
# following URL added on February 11, 2014:
echo "http://www.desmoulins.fr/index.php?pg=scripts!online!feuilles!form_feuille_apprendre_ecriture"
# following URL added on February 11, 2014:
echo "http://www.thatquiz.org/fr-D-z2/vocabulaire/Francais/"

###############################################################################################
#     Links for authors of Astronomy books                                                    #
###############################################################################################

echo "Check with book publisher in which format the digitized book needs to be sent to the publisher"
echo "(preferably latex instead of hybrid PDF-ODF format, Word .docx format, etc...)"
echo "create star maps using stellarium, save as png, and import into latex document"
echo "get bibliography citations at http://www.ottobib.com  using ISBN number and convert info to bibtex plain text .bib file for use in Latex document"
echo "get bibliography citations at http://scholar.google.be using full title and author and choose import to bibtex"
echo "For example use - filetype:pdf author:'h karttunen'  -  as search term in http://scholar.google.be"
echo "For example use - site:arxiv.org intext:"habitable zone" - as search term in http://www.google.be/"
echo "Get more information about latex package by using command   texdoc <packagename> , for example: texdoc graphicx"

###############################################################################################
#     Links for data scientists                                                               #
###############################################################################################

# Reproducible, scientific, open-source report sharing procedure:
# 1) install R, RStudio, texmaker and knitr
# 2) Create .Rnw document using texmaker+knitr - knitr is slightly better than Sweave
# 3) Add an explanatory comment after each line of R code inside the .Rnw document
# 4) Share new .Rnw document and source .csv datafiles on https://github.com/
# knitr install procedure:

# cd; rm knitr_*.tar.gz
# git clone https://github.com/yihui/knitr.git
# sudo apt-get update
# sudo apt-get install texinfo
# sudo apt-get install texlive-fonts-extra
# R CMD build knitr
# R CMD INSTALL knitr_*.tar.gz
# sudo cp ~/knitr/inst/bin/knit /usr/bin/knit
# cd knitr
# make check
# git clone https://github.com/MarkRijckenberg/book-template-for-texstudio.git
# cd book-template-for-texstudio/
# texmaker main.Rnw
# Configure texmaker version 4.1.1 or newer as follows:
# Texmaker::Options::Configure Texmaker::Commands::R Sweave command should be  Rscript -e "library(knitr); knit('%.Rnw')"
# Texmaker::Options::Configure Texmaker::Quick Build command option should be Sweave + pdflatex + View PDF
# Then press F1,F12,F11,F1,F1 to compile from .Rnw to .tex to .pdf file and to preview it automatically.

# following URL added on February 26, 2014:
# Use Google Docs Forms (or kwiksurveys.com) to create online survey that allows free export of data into R or RStudio
echo "https://www.ashrae.org/File%20Library/docLib/Public/20100301_how_2_app_googledocs.pdf"
# following URL added on February 26, 2014:
# texmaker/knitr source code (.Rnw files) for OpenIntro Labs is here:
echo "http://www.openintro.org/download.php?file=os2_lab_source&referrer=/stat/labs.php"
# following URL added on February 26, 2014:
# Explanation on how to use texmaker with knitr:
echo "http://yihui.name/knitr/demo/editors/"
# Explanation on how to use .Rnw files and RStudio with knitr:
echo "http://kbroman.github.io/knitr_knutshell/pages/latex.html"
# Data Wrangling Cheat Sheet using dplyr and tidyr packages:
echo "http://www.rstudio.com/resources/cheatsheets/"
# following URL added on July 10, 2014:
# RStudio Shiny Apps cheatsheet:
echo "http://shiny.rstudio.com/articles/cheatsheet.html"
# following URL added on February July 10, 2014:
# principles and practice of reproducible research with R
echo "https://osf.io/s9tya/wiki/home/"
echo "http://statsteachr.org/modules/view/40"
echo "http://reproducibleresearch.net/links/"

# following URL added on February 13, 2015:
# detailed examples on how to use ggplot2:
echo "http://www.sthda.com/"
# following URL added on February 19, 2014:
# free guides
echo "http://onepager.togaware.com/"
# following URL added on February 19, 2014:
echo "http://www.Rdocumentation.org"
# following URL added on February 19, 2014:
echo "http://www.r-bloggers.com/"

# following URL added on February 19, 2014:
# sample data is here:
echo "http://dataferrett.census.gov/LaunchDFA.html"
# following URL added on February 19, 2014:
echo "http://www.r-statistics.com/2013/07/analyzing-your-data-on-the-aws-cloud-with-r/"
# following URL added on February 26, 2014:
echo "http://jeromyanglim.blogspot.be/search/label/R"

# following URL added on February 19, 2014:
# STEP 1: introduction to R and R-Studio for beginners
echo "http://jsresearch.net/"
# following URL added on March 7, 2014:
# Step 2 Data Smart
echo "http://www.amazon.fr/Data-Smart-Science-Transform-Information/dp/111866146X/ref=sr_1_1?ie=UTF8&qid=1394192108&sr=8-1&keywords=Data+Smart%3A+Using+Data+Science+to+Transform+Information+into+Insight"
# following URL added on March 16, 2014:
# one of the authors of the Data Smart book:
echo "http://www.evanmiller.org/"
# following URL added on March 16, 2014:
# spreadsheets used in Data Smart book:
echo "http://eu.wiley.com/WileyCDA/WileyTitle/productCd-111866146X.html"
# following URL added on August 28, 2014:
echo "http://swirlstats.com/students.html"
echo "https://github.com/swirldev/swirl_courses#swirl-courses"
# following URL added on March 7, 2014:
# STEP 4: following URL added on February 28, 2014:
echo "http://www.amazon.fr/Practical-Data-Science-Nina-Zumel/dp/1617291560/ref=sr_1_1?ie=UTF8&qid=1393583397&sr=8-1&keywords=practical+data+science+with+r"

# following URL added on March 7, 2014:
echo "https://www.edx.org/"
# following URL added on March 12, 2014:
echo "http://www.google.com/trends"

# following URL added on March 18, 2014:
# world news site for data scientists
echo "http://fivethirtyeight.com/"
# following URL added on March 29, 2014:
# list of data visualisation tools
echo "http://selection.datavisualization.ch/"
# list of data visualisation tools
# following URL added on November 27, 2014:
echo "http://www.maartenlambrechts.be/category/datajournalistiek/"
# following URL added on March 29, 2014:
# search engine for R
echo "http://www.rseek.org/"
# following URL added on April 22, 2014:
# Cookbook for R
echo "http://www.cookbook-r.com/"
# R Graphics Cookbook - Practical Recipes for Visualizing Data - Winston Chang - 2012
echo "http://shop.oreilly.com/product/0636920023135.do"
# Data Camp - online interactive tool that teaches how to use R
# following URL added on April 25, 2014:
echo "https://www.datacamp.com/courses/introduction-to-r"
# following URL added on September 7, 2014:
echo "https://www.codeschool.com/courses/try-r"
# time series analysis using R
# following URL added on May 18, 2014:
echo "http://www.statmethods.net/advstats/timeseries.html"
echo "http://a-little-book-of-r-for-time-series.readthedocs.org/en/latest/src/timeseries.html"
echo "https://www.otexts.org/fpp"
echo "http://cran.r-project.org/doc/contrib/Ricci-refcard-ts.pdf"
echo "http://www.statoek.wiso.uni-goettingen.de/veranstaltungen/zeitreihen/sommer03/ts_r_intro.pdf"
echo "https://onlinecourses.science.psu.edu/stat510/"
# following URL added on June 24, 2014:
echo "http://www.scoop.it/t/r-for-journalists"
# following URL added on September 9, 2014:
echo "http://www.bioconductor.org/install/"
# following URL added on September 9, 2014:
# run R online:
echo "http://statace.com/#features"
echo "http://www.roncloud.com/"
echo "http://www.compileonline.com/execute_r_online.php"
echo "http://www.r-fiddle.org/"
echo "http://pbil.univ-lyon1.fr/Rweb/Rweb.general.html"
# following URL added on September 15, 2014:
# detailed examples of supervised and unsupervised learning and time series analysis in R:
echo "http://www.rdatamining.com/docs"

###############################################################################################
#     Sabermetrics                                                                            #
###############################################################################################
# STEP 5: following URL added on June 11, 2014:
echo "http://www.amazon.com/Analyzing-Baseball-Data-Chapman-Series/dp/1466570229/ref=sr_1_1?ie=UTF8&qid=1402506648&sr=8-1&keywords=analyzing+baseball+data+with+r"
# following URL added on June 11, 2014:
echo "http://baseballwithr.wordpress.com/2014/03/17/introduction-to-openwar/"
# following URL added on May 29, 2014:
echo "https://books.google.com/ngrams/graph?content=sabermetrics%2Csabermetric%2Csabermetrician&year_start=1978&year_end=2014&corpus=15&smoothing=3&share=&direct_url=t1%3B%2Csabermetrics%3B%2Cc0%3B.t1%3B%2Csabermetric%3B%2Cc0%3B.t1%3B%2Csabermetrician%3B%2Cc0"
# following URL added on August 29, 2014:
echo "http://www.datascienceriot.com/"

###############################################################################################
#     R model generation and selection tools:                                                 #
###############################################################################################

# following URL added on April 16, 2014:
# how to create hybrid CART-logit model (CART-logistic regression model) in R:
# approach did not work well on real world data set full of missing values
echo "www.casact.org/education/specsem/f2005/handouts/cart.ppt"
# following URL added on April 17, 2014:
# automated R model selection using glmulti R package as replacement for glm 
echo "http://www.jstatsoft.org/v34/i12/paper"
# following URL added on April 17, 2014:
# Excellent examples of using glmulti R package as replacement for glm :
echo "http://rstudio-pubs-static.s3.amazonaws.com/2897_9220b21cfc0c43a396ff9abf122bb351.html"
# following URL added on April 19, 2014:
# Feature selection using caret
echo "http://caret.r-forge.r-project.org/featureselection.html"
echo "http://caret.r-forge.r-project.org/modelList.html"
# select best algorithm by testing them on train data set in Weka Experimenter:
echo "http://machinelearningmastery.com/design-and-run-your-first-experiment-in-weka/"
# most powerful R feature selection method to create an accurate model:
# Perform Hyperparameter optimization using libsvm as explained here:
echo "https://en.wikipedia.org/wiki/Hyperparameter_optimization"
echo "http://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf"
# Alternative to R Markdown for Data Workflow Visualization: KNIME (Konstanz Information Miner)
# KNIME is a Data Workflow Visualization tool
# following URL added on April 25, 2014:
echo "http://tech.knime.org/files/KNIME_quickstart.pdf"
# following URL added on July 24, 2014:
echo "http://cdn.oreillystatic.com/en/assets/1/event/115/Data%20Workflows%20for%20Machine%20Learning%20Presentation.pdf"


# liblinear is good model to use when number of train data rows (4600) > number of features/variables (110) 
# -> so use liblinear R package -> computations via liblinear much quicker than via libsvm!
# following URL added on April 23, 2014:
echo "http://cran.r-project.org/web/packages/LiblineaR/LiblineaR.pdf"

###############################################################################################
#     Data Science toolkit virtual machine images                                             #
###############################################################################################
# following URL added on July 24, 2014:
echo "http://www.datasciencetoolkit.org/developerdocs#setup"
###############################################################################################
#     Data Science magazines and journals                                                     #
###############################################################################################
# following URL added on July 18, 2014:
echo "http://www.jds-online.com/"
echo "http://radar.oreilly.com/data"
#######################################################
# how to clean data and perform data imputation in R  #
#######################################################
# following URL added on April 25, 2014:
echo "http://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf"
# Data Cleaning for Beginners: Part 2
# following URL added on April 25, 2014:
echo "http://statsguys.wordpress.com/2014/01/11/data-analytics-for-beginners-pt-2/"

# Free online courses:

# following URL added on March 29, 2014:
# list of online course, use search function in top right corner of page:
echo "http://www.mooc-list.com/"

# free Stanford courses about R and other subjects
# following URL added on March 12, 2014:
echo "https://class.stanford.edu"
# following URL added on February 28, 2014:
# Free online Data Science courses here:
echo "https://www.udacity.com/courses#!/Data%20Science"
# Free online Data Science courses here:
# following URL added on March 12, 2014:
echo "https://courses.edx.org/dashboard"
# following URL added on March 30, 2014:
echo "https://www.coursera.org/courses?orderby=upcoming&lngs=en&cats=cs-theory,cs-systems,cs-programming,cs-ai,stats"
# following URL added on July 21, 2014:
echo "https://www.khanacademy.org/math/probability/statistics-inferential"
# following URL added on July 30, 2014:
echo "https://www.udemy.com/courses/search/?q=data+science&view=list&sort=price-low-to-high"
# following URL added on February 28, 2014:
# Free PDF book "An Introduction to Statistical Learning with Applications in R"
# Very handy book that complements the edX course "MITx: 15.071x The Analytics Edge"
echo "http://www-bcf.usc.edu/~gareth/ISL/"
# following URL added on April 3, 2014:
# book by Julian Faraway on CranR, written in July 2002:
echo "http://cran.r-project.org/doc/contrib/Faraway-PRA.pdf"
# following URL added on March 28, 2014:
# Systems approaches to improving data quality 
echo "http://mitiq.mit.edu/ICIQ/Documents/IQ%20Conference%201996/Papers/SystemsApproachestoImprovingDataQuality.pdf"
# following URL added on March 14, 2014:
echo "https://www.class-central.com/"
# following URL added on April 1, 2014:
# Natural Language Processing - linked to Text Mining
echo "https://www.youtube.com/results?search_query=1%20-%201%20Stanford%20NLP%20-%20Professor%20Dan%20&sm=3"
# following URL added on April 4, 2014:
# Supervised Learning Workflow / Data Analytics Workflow
echo "http://statsguys.files.wordpress.com/2014/03/supervisedworkflow.png"
# NFL dataset for R users in SQL format:
echo "http://rpubs.com/rseiter/22093"


###############################################################################################
#     Open data formats and importing data into R                                             #
###############################################################################################
# Data Sources for Data Scientists
echo "http://www.noodletools.com/debbie/resources/math/stats.html"
# OAD Open Data Repositories (including Repositories about Astronomy)
echo "http://oad.simmons.edu/oadwiki/Data_repositories"
# following URL added on March 4, 2014:
# NASA Data Sources for Data Scientists - data can be manually exported into .csv format
echo "http://mynasadata.larc.nasa.gov/las/UI.vm"
# following URL added on March 7, 2014:
# Flemish government's open data initiative uses JSON format for open data sources/sets instead of .csv format
echo "http://data.opendataforum.info/"
# following URL added on March 25, 2014:
echo "https://www.opencpu.org/posts/jsonlite-a-smarter-json-encoder/"
# following URL added on March 4, 2014:
# How to import data into R from various types of data sources:
echo "http://cran.r-project.org/doc/manuals/r-release/R-data.pdf"
# following URL added on April 1, 2014:
echo "https://github.com/rOpenHealth"
# following URL added on September 16, 2014:
echo "https://ropengov.github.io/"
# following URL added on May 17, 2014:
echo "http://www.infochimps.com/datasets/"
# following URL added on May 18, 2014:
echo "https://datamarket.com/"
# following URL added on July 10, 2014:
# Dryad Digital Repository 
echo "http://datadryad.org"
# following URL added on July 10, 2014:
# Access Quandl open data sets using Quandl R package:
echo "http://www.quandl.com/"
echo "https://s3.amazonaws.com/quandl-static-content/Documents/Quandl+-+R+Cheat+Sheet.pdf"
# following URL added on August 14, 2014:
echo "http://www.data.gov/"
# following URL added on October 29, 2014:
echo "http://opendata.stackexchange.com/"

#######################################################################################################
#     Online data analytics challenges requiring use of R or python                                   #
#######################################################################################################
# Kaggle competitions
echo "http://www.kaggle.com/"
# Synapse challenges
echo "https://www.synapse.org/#"
# Coursolve challenges
echo "https://www.coursolve.org"


#######################################################################################################
#     Combine big data datasets with R, RStudio and Amazon EC2 or Google Big Data infrastructure      #
#######################################################################################################
# The data.table package is being increasingly used in fields such as finance, insurance and genomics, 
# and it is making its name as the number one choice for handling large datasets (1Gb - 100GB) in R. 
# Data.table provides you with an enhanced version of a data.frame. The speed and simplicity of using 
# data.table will be a revelation. It reduces your programming and the computing time significantly. 
# following URL added on October 10, 2014:
echo "https://www.datacamp.com/courses/data-analysis-the-data-table-way?utm_source=Data.table%20launch%20email&utm_medium=email&utm_content=finance%20-%20zivot&utm_campaign=Data.table%20launch%20"
# use R,RStudio,postgresql-9.3,postgresql-plr,MADlib,PivotalR to run MADlib in-database modeling 
# functions in database, not in R
echo "http://www.oscon.com/oscon2014/public/schedule/detail/37713"
echo "http://www.louisaslett.com/RStudio_AMI/"
echo "https://developers.google.com/bigquery/"
# following URL added on September 20, 2014:
# Big Query and Data Analytics applied to soccer:
echo "https://github.com/GoogleCloudPlatform/ipython-soccer-predictions"
# following URL added on November 20, 2014:
# combine SciDB (allow big data sets),RStudio (data analytics) and Shiny(interactive visualization)
echo "http://illposed.net/scidb.pdf"
# following URL added on November 28, 2014:
# combine Apache Spark with Python using pyspark:
echo "https://www.edx.org/course/introduction-to-big-data-with-apache-spark-uc-berkeleyx-cs100-1x"
# following URL added on November 28, 2014:
# combine Apache Spark with R using SparkR:
echo "https://www.youtube.com/watch?v=CUX1SG9zTkU&list=PL-x35fyliRwiuc6qy9z2erka2VX8LY53x"
# following URL added on February 18, 2015:
# Prerequisites:
# CUDA toolkit, Python 2.7.x, numpy, pandas, matplotlib, and scikit-learn, lasagne
# lasagne is a library for building Convolutional neural networks with Python and Theano
echo "http://danielnouri.org/notes/2014/12/17/using-convolutional-neural-nets-to-detect-facial-keypoints-tutorial/"

#######################################################################################################
#     Data Science programming languages - learning requirements:                                      #
#     R,RStudio,MySQL commands,python                                                                 #
#######################################################################################################
# following URL added on March 25, 2014:
# R Reference Card 2.0
echo "http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf"
# following URL added on February 19, 2014:
echo "http://www.rstudio.com/"
echo "http://bigdatauniversity.com/wpcourses/"

# list of MySQL commands to use with RMySQL package in R:
echo "http://www.pantz.org/software/mysql/mysqlcommands.html"
# list of different types of SQL joins
echo "http://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins"
# following URL added on March 7, 2014:
# Step 3 Sams Teach Yourself SQL in 10 Minutes (4th Edition)
echo "Learn MySQL commands = de facto SQL (dialect) standard"
echo "http://www.amazon.fr/Sams-Teach-Yourself-Minutes-Edition-ebook/dp/B009XDGF2C/ref=sr_1_1?ie=UTF8&qid=1394192160&sr=8-1&keywords=Sams+Teach+Yourself+SQL+in+10+Minutes+%284th+Edition%29"

# following URL added on July 8, 2014:
echo "http://www.codecademy.com/tracks/python"
echo "https://developers.google.com/edu/python/"
# ipython notebook webserver in virtualbox VM configured using vagrant (configure time using chef in VM: 31 minutes)
# accessible on host server via http://localhost:8888
echo "https://rawgit.com/ptwobrussell/Mining-the-Social-Web-2nd-Edition/master/ipynb/html/_Appendix%20A%20-%20Virtual%20Machine%20Experience.html"
echo "http://cloud.shogun-toolbox.org/"

#####################################################################################################
#    R User Conference  - presentations and slides about using R and applied predictive modeling      #
#######################################################################################################
# following URL added on July 10, 2014:
# predictive modeling = machine learning
# The R User Conference:
echo "http://user2014.stat.ucla.edu/"
echo "http://static.squarespace.com/static/51156277e4b0b8b2ffe11c00/t/53ad86e5e4b0b52e4e71cfab/1403881189332/Applied_Predictive_Modeling_in_R.pdf"
# following paper describes dangers of overfitting and "curse of dimensionality":
echo "http://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf"
# OSCON 2014 conference
echo "http://www.oscon.com/oscon2014/public/schedule/detail/37713"
# Strata Oreilly conference
echo "http://strataconf.com/strata2014/public/schedule/proceedings"
# Data Day Texas conference
echo "http://datadaytexas.com/"

###############################################################################################
#     Personal study requirements                                                             #
###############################################################################################
# Informatica PowerCenter ETL
# IBM Cognos Business Intelligence V10.1 Handbook:
echo "http://www.redbooks.ibm.com/redbooks/pdfs/sg247912.pdf"
echo "http://www.redbooks.ibm.com/redbooks.nsf/searchsite?SearchView&query=cognos"
# The Data Warehouse Toolkit: The Definitive Guide to Dimensional Modeling Paperback – July 1, 2013
# Kimball lifecycle
# Microsoft SQL Server 2014 Business Intelligence Development Beginner's Guide
# !!!! Data Smart ('light' data analytics using Microsoft Excel)
echo "http://www.amazon.fr/Data-Smart-Science-Transform-Information/dp/111866146X/ref=sr_1_1?ie=UTF8&qid=1394192108&sr=8-1&keywords=Data+Smart%3A+Using+Data+Science+to+Transform+Information+into+Insight"
# !!!! An Introduction to Statistical Learning
echo "http://www-bcf.usc.edu/~gareth/ISL/"
# !!!! OpenIntro Statistics 2nd edition
echo "http://www.openintro.org/stat/textbook.php?stat_book=os"
# study ggvis RStudio visualization package
echo "http://ggvis.rstudio.com/"
echo "https://www.datacamp.com/courses/ggvis/free-preview-ggvis?ex=2"
# SCRUM
echo "http://mgmtplaza.com/downloads/Scrum%20Training%20Manual.pdf"
# Agile
