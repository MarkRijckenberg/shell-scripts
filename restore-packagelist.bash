#!/bin/bash
# !!!!! WINDOWS 8.1 64-bit users should use ninite.com, Glary Utilities and avast! Premier Software Updater
# !!!!! for semi-automated Windows application deployments and updates
# !!!!! WINDOWS 8.1 64-bit users should install "Classic Start" Ninite.com utility
# !!!!! and disable Superfetch Windows service to avoid hard disk thrashing and excessive memory use
# !!!!! WINDOWS 8.1 64-bit users should use http://www.pendrivelinux.com/yumi-multiboot-usb-creator/  to
# !!!!! to add operating systems one by one in a flexible manner onto a multi-boot multi-OS USB stick
# !!!!! WINDOWS 8.1 64-bit users should install new games via Steam and via www.pokki.com
# !!!!! WINDOWS 8.1 64-bit App Store URL: http://windows.microsoft.com/en-us/windows-8/apps#Cat=t1
# !!!!! WINDOWS 8.1 64-bit Second App Store URL: http://www.pokki.com/

# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily restore packages into a clean install of Linux Mint 16 Cinnamon 64-bit
# REQUIRES: Linux Mint 16 Cinnamon 64-bit (to support UEFI+SecureBoot+biber+bibtex+bluetooth), cinnamon-bluetooth, 
#           wget, apt-get, unp, wine, biber, biblatex
# Use Cinnamon instead of Unity interface, because Unity causes Teamviewer sessions to slow down due to window 
# animation in Unity
# REQUIRED FREE DISKSPACE FOR LINUX MINT 16: 4 GB of free disk space in root partition
# REQUIRED FREE DISKSPACE FOR BASEPACKAGES:  1.4 GB of free disk space in root partition after installing Linux Mint DVD
# REQUIRED FREE DISKSPACE FOR PPA PACKAGES:  1.4 GB of free disk space in root partition after installing Linux Mint DVD
# TOTAL AMOUNT OF REQUIRED DISKSPACE FOR LINUX MINT 16 + BASEPACKAGES + PPA PACKAGES
# = 4 GB + 1.4 GB + 1.4 GB = 6.8 GB
# COMPATIBILITY WITH WIRELESS BLUETOOTH SPEAKERS: bluetooth speakers fully work in Linux Mint 16 Cinnamon
# thanks to cinnamon-bluetooth package, but not in Lubuntu 13.10 Razor-QT desktop
# INSTALL DURATION: 20 minutes for install of Linux Mint + 74 minutes for install of base packages and PPA packages
# Author: Mark Rijckenberg
# Copyright (c) 20120812
# REVISION DATE: 20140112
# Updated by: markrijckenberg at gmail dot com

PATH=/usr/sbin:/usr/bin:/sbin:/bin
#Prerequisites: USB drives SAMSUNG and IOMEGA need to be mounted correctly in order for this script to work correctly!

MACHINE_TYPE=`uname -m`

# define basepackage filename variables - VERSION NUMBERS FREQUENTLY CHANGE!!
SKYPEFILENAME="skype-ubuntu-precise_4.2.0.13-1_i386.deb"
YEDFILENAME="yEd-3.11.1_32-bit_setup.sh"

# define Astronomy filename variables
DUFILENAME="DUv3_9pview.tgz"
NIGHTSHADEFILENAME="nightshade-11.12.1.tar.gz"
SCISOFTFILENAME="scisoft-7.7.0"
SKYVIEWERFILENAME="skyviewer-1.0.0"
C2AFILENAME="c2a_full_2_0_49.zip"
AUDELAFILENAME="audela-2.0.0"

#define source directories
HOME=$(eval echo ~${SUDO_USER})
SOURCE2=/etc/
SOURCE3=/media/windows/rsync/

#define target directories where backup will be stored
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

# define aliases in ~/.bashrc file
echo "alias apti='sudo aptitude update && sudo aptitude install '" >> ~/.bashrc
echo "alias aptr='sudo aptitude remove '" >> ~/.bashrc
echo "alias aptp='sudo aptitude purge '" >> ~/.bashrc
echo "alias aptu='sudo aptitude update'" >> ~/.bashrc
echo "alias apts='sudo aptitude search '" >> ~/.bashrc
echo "alias d-u='sudo aptitude update && sudo aptitude dist-upgrade'" >> ~/.bashrc

# turn off apport error/crash reporting
sudo sed -i s/enabled=1/enabled=0/ /etc/default/apport

# refresh list of available packages in Ubuntu repositories
sudo DEBIAN_FRONTEND=noninteractive apt-key add Repo.keys
sudo DEBIAN_FRONTEND=noninteractive apt-get update
# install list of packages defined in packages files
# allpackages = basepackages + astropackages
# sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install `cat  allpackages` -o APT::Install-Suggests="false"

# uninstall pulseaudio - pulseaudio can cause skype to malfunction with loss of microphone and sound output
# commented out following line, because it will break bluetooth support in Linux Mint
# sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge pulseaudio*
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge arno-iptables-firewall
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge ufw

# install dupeguru-me which can find and delete similar music filenames using fuzzy logic
# rerun dupeguru-me on /media/IOMEGA/downloads/Youtube-playlists  after each mp3 conversion using YouTubeToMP3
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:hsoft/ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install dupeguru-me

# Install razorqt desktop environment
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:razor-qt/ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install razorqt razorqt-desktop

# Install lxde-qt desktop environment => merge of lxde and razorqt desktops
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:lubuntu-dev/lubuntu-daily
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install pcmanfm-qt lxpanel-qt lxsession lximage-qt  lxinput-qt lxrandr-qt

# install base packages using basepackages file
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install aptitude
sudo DEBIAN_FRONTEND=noninteractive aptitude install `cat basepackages` -o APT::Install-Suggests="false"

# create symbolic link to wkhtmltopdf in /usr/local/bin after installing base packages
sudo ln -s /usr/bin/wkhtmltopdf /usr/local/bin/html2pdf

# install grub customizer
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:danielrichter2007/grub-customizer
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install grub-customizer

# install newest version of Libreoffice
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:libreoffice/ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install libreoffice

#install deprecated, obsolete hal package so that fluendo content and DRM-demanding
# Flash websites are supported in Lubuntu 13.10 or newer
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:mjblenner/ppa-hal
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install hal

#install i-nex - I-nex is similar to CPU-Z in Windows, it uses the same interface to display your hardware information.
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:i-nex-development-team/daily
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:nemh/gambas3
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install i-nex 

# install Variety - cool wallpaper changer
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:peterlevi/ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
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
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:linrunner/tlp
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install tlp tlp-rdw

# Install kazam screen recording tool for Ubuntu 12.04 / 12.10 / 13.04
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:kazam-team/stable-series
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install kazam

# install hotshots Screen Capture Tool In Ubuntu 12.04 / 12.10 / 13.04
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:dhor/myway
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install hotshots

# install Final Term - excellent Terminal emulator in  Ubuntu 12.04 / 12.10 / 13.04
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:finalterm/daily
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install finalterm

# install Google Music Manager - sync local mp3s in Ubuntu with ios or Android device
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install google-musicmanager-beta
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install google-musicmanager

# install newest version of VLC player
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:videolan/master-daily
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install vlc


# install spotify - can sync mp3 files between Ubuntu 13.10 and ipod nano 6th generation
#sudo DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
#sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install spotify-client

# install kdenlive video editor
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes  ppa:philip5/extra
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install kdenlive

# install openshot which is a simple and easy to use video editor, like a good substitute for the windows movie maker
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:openshot.developers/ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install openshot

# install Handbrake - open source video transcoder - add Subtitles (VobSub, Closed Captions CEA-608, SSA, SRT)
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:stebbins/handbrake-releases
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install handbrake 

# install SopCast webTV player
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:lyc256/sopcast-player-ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  install sopcast-player 

# install qbittorrent client
# import RSS feeds from http://showrss.info/?cs=feeds  into qbittorrent client
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:hydr0g3n/qbittorrent-stable
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install qbittorrent

# install desurium game client
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:makson96/desurium
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install desurium

# install 64-bit compatible Steam client
wget -c media.steampowered.com/client/installer/steam.deb
sudo dpkg -i steam.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
 

# install kde desktop environment
#sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes  ppa:kubuntu-ppa/backports
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
#sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes   install kubuntu-desktop

# Cuttlefish is an ingenious little tool. It allows you to define a set of actions that occur when a certain stimulus is activated.
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:noneed4anick/cuttlefish
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install cuttlefish 

# Install Ubuntu Tweak to easily uninstall old kernel versions
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:tualatrix/ppa
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install ubuntu-tweak

# install skype
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  remove skype skype-bin
wget http://download.skype.com/linux/`echo $SKYPEFILENAME`
sudo dpkg -i skype-ubuntu*.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install Y PPA Manager
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:webupd8team/y-ppa-manager
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install  y-ppa-manager

# libdvdcss2, to play encrypted DVDs
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install libdvdcss2
sudo /usr/share/doc/libdvdread4/./install-css.sh



###############################################################################################
#     WEBBROWSER SOFTWARE SECTION                                                             #
###############################################################################################



if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
# install Google Chrome browser which includes newest version of Adobe Flash - other browsers do not
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
# fix the Google Chrome dependencies issue
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install 4kyoutubetomp3 - extremely fast Youtube playlist downloader
VIDEODOWNLOADERREMOTEDIR="https://code.google.com/p/4kdownload/"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*tubetomp3[^"]*amd64*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd
rm -rf "$dir"
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install 4kvideodownloader that converts personal Youtube playlists to Youtube mp3s
VIDEODOWNLOADERREMOTEDIR="https://code.google.com/p/4kdownload/"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*videodownloader[^"]*amd64*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd
rm -rf "$dir"
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install Google Earth
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
sudo dpkg -i google-earth-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install newest wine version 
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes --force-yes -f ppa:ubuntu-wine/ppa 
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f  install wine1.6 winetricks wine1.6-amd64

# install Teamviewer server + client which depends on wine1.6
wget http://download.teamviewer.com/download/teamviewer_linux.deb
sudo dpkg -i teamviewer_linux.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
# teamviewer autostart fix procedure - add configuration lines below to /etc/rc.local
sudo -k teamviewer --daemon start
cd /opt/teamviewer9/tv_bin/script
sudo cp teamviewerd.sysv /etc/init.d/
sudo chmod 755 /etc/init.d/teamviewerd.sysv
sudo update-rc.d teamviewerd.sysv defaults
/opt/teamviewer9/tv_bin/script/teamviewer --daemon start &
# !!!!!! Also add teamviewer program to KDE's Autostart (autostart launch command to use: teamviewer)

# install youtube-to-mp3 program
wget http://www.mediahuman.com/download/YouTubeToMP3.amd64.deb
sudo dpkg -i YouTubeToMP3.amd64.deb 
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
# install dupeguru-me which can find and delete similar music filenames using fuzzy logic
# rerun dupeguru-me on /media/IOMEGA/downloads/Youtube-playlists  after each mp3 conversion using YouTubeToMP3

else
  # 32-bit stuff here
  
# install youtube-to-mp3 program
wget http://www.mediahuman.com/download/YouTubeToMP3.i386.deb
sudo dpkg -i YouTubeToMP3.i386.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install
# install dupeguru-me which can find and delete similar music filenames using fuzzy logic
# rerun dupeguru-me on /media/IOMEGA/downloads/Youtube-playlists  after each mp3 conversion using YouTubeToMP3

# install Google Chrome browser which has better support for Flash websites (Youtube, ...)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
sudo dpkg -i google-chrome*.deb
# fix the Google Chrome dependencies issue
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install 4kyoutubetomp3 - extremely fast Youtube playlist downloader
VIDEODOWNLOADERREMOTEDIR="https://code.google.com/p/4kdownload/"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*tubetomp3[^"]*i386*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd
rm -rf "$dir"
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install 4kvideodownloader that converts personal Youtube playlists to Youtube mp3s
VIDEODOWNLOADERREMOTEDIR="https://code.google.com/p/4kdownload/"
url=$(wget -O- -q --no-check-certificate `echo $VIDEODOWNLOADERREMOTEDIR` |  sed -ne 's/^.*"\([^"]*videodownloader[^"]*i386*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $url`
# Install the package
sudo dpkg -i "${url##*/}"
# Clean up
rm "${url##*/}"
cd
rm -rf "$dir"
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install Google Earth
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb
sudo dpkg -i google-earth-stable_current_i386.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# install newest wine version 
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes --force-yes -f ppa:ubuntu-wine/ppa 
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install wine1.6-i386
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f install wine1.6 winetricks

# install Teamviewer server + client which depends on wine1.6
wget http://download.teamviewer.com/download/teamviewer_linux.deb
sudo dpkg -i teamviewer_linux.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -f install

# teamviewer autostart fix procedure - add configuration lines below to /etc/rc.local
sudo -k teamviewer --daemon start
cd /opt/teamviewer9/tv_bin/script
sudo cp teamviewerd.sysv /etc/init.d/
sudo chmod 755 /etc/init.d/teamviewerd.sysv
sudo update-rc.d teamviewerd.sysv defaults
/opt/teamviewer9/tv_bin/script/teamviewer --daemon start &
# !!!!!! Also add teamviewer program to KDE's Autostart (autostart launch command to use: teamviewer)

fi

# install Opera browser
# wget -O- http://deb.opera.com/archive.key | sudo DEBIAN_FRONTEND=noninteractive apt-key add -
#sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list'
#sudo DEBIAN_FRONTEND=noninteractive apt-get update
# sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install opera

# Enable and upgrade the open-source graphics drivers for Intel, AMD Radeon, and Nouveau (NVIDIA)
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository  --yes --force-yes -f ppa:oibaf/graphics-drivers
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes -f dist-upgrade

# OBSOLETE - install Multimedia codecs
# sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo DEBIAN_FRONTEND=noninteractive apt-get --quiet update && sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo DEBIAN_FRONTEND=noninteractive apt-get --quiet update
# sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes install non-free-codecs libdvdcss

# install Realplayer (latest version is from 2009)
#sudo DEBIAN_FRONTEND=noninteractive apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install lsb
#wget http://client-software.real.com/free/unix/RealPlayer11GOLD.deb
#sudo dpkg -i RealPlayer11GOLD.deb

# clean up current directory
echo "Performing file cleanup"
mv *.zip $ZIP
mv *.pdf $PDF
mv *.deb $DEB
mv *.km? $KMZ
mv *gz $TAR
rm *.exe

# uninstall Java due to all the critical security issues in 2013
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove java-common
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove default-jre
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove gcj-?.?-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove openjdk-?-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes remove mysql-server-core-?.?
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  remove unity-lens-shopping
# sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge pulseaudio*
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge arno-iptables-firewall
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  purge ufw
sudo DEBIAN_FRONTEND=noninteractive apt-get autoclean
sudo DEBIAN_FRONTEND=noninteractive apt-get clean
sudo rm /etc/apt/sources.list.d/*

# Install yEd editor 
# (powerful desktop application that can be used to quickly and effectively generate high-quality diagrams)
# Save diagrams in .pdf format so they can be included as graphics in a new latex document in texmaker
# Allows easy creation of Entity Relationship (ER) diagrams (as part of data modeling by data scientist)
wget http://www.yworks.com/products/yed/demo/`echo $YEDFILENAME`
sh `echo $YEDFILENAME`

###############################################################################################
#     ASTRONOMY SOFTWARE SECTION                                                              #
###############################################################################################

sudo DEBIAN_FRONTEND=noninteractive apt-get install  `cat  astropackages` -o APT::Install-Suggests="false"

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

if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
# download and decompress IRAF - Image Reduction and Analysis Facility, a general purpose
# software system for the reduction and analysis of astronomical data
echo "Downloading and decompressing IRAF - Image Reduction and Analysis Facility"
wget ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86_64.tar.gz
unp iraf.lnux.x86_64.tar.gz

echo "Downloading and installing skychart"
SKYCHARTREMOTEDIR="http://sourceforge.net/projects/skychart/files/1-%20cdc-skychart/version_3.8/"
url=$(wget -O- -q --no-check-certificate `echo $SKYCHARTREMOTEDIR` |  sed -ne 's/^.*"\([^"]*skychart[^"]*amd64*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $SKYCHARTREMOTEDIR``echo $url`
# Install the package
sudo dpkg -i $url
# Clean up
rm $url
cd
rm -rf "$dir"
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

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
echo "Downloading and decompressing IRAF - Image Reduction and Analysis Facility"
wget ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86.tar.gz
unp iraf.lnux.x86.tar.gz

echo "Downloading and installing skychart"
SKYCHARTREMOTEDIR="http://sourceforge.net/projects/skychart/files/1-%20cdc-skychart/version_3.8/"
url=$(wget -O- -q --no-check-certificate `echo $SKYCHARTREMOTEDIR` |  sed -ne 's/^.*"\([^"]*skychart[^"]*i386*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $SKYCHARTREMOTEDIR``echo $url`
# Install the package
sudo dpkg -i $url
# Clean up
rm $url
cd
rm -rf "$dir"
cd
sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

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

wget http://sourceforge.net/projects/skychart/files/2-catalogs/Stars/skychart-data-stars_3.8-2293_all.deb
sudo dpkg -i skychart-data-stars_3.8-2293_all.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

wget http://sourceforge.net/projects/skychart/files/2-catalogs/Nebulea/skychart-data-dso_3.8-2293_all.deb
sudo dpkg -i skychart-data-dso_3.8-2293_all.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get -f install

wget http://sourceforge.net/projects/skychart/files/2-catalogs/Nebulea/skychart-data-pictures_3.1-1466_all.deb
sudo dpkg -i skychart-data-pictures_3.1-1466_all.deb
sudo DEBIAN_FRONTEND=noninteractive apt-get -f install


###############################################################################################
#     DOWNLOAD TRIATLAS PDF FILES BEFORE ANY OTHER PDF FILES                                  #
###############################################################################################
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
mv *.zip $ZIP
mv *.pdf $PDF
mv *.deb $DEB
mv *.km? $KMZ
mv *gz $TAR
rm *.exe

# uninstall Java due to all the critical security issues in 2013
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove java-common
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove default-jre
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove gcj-?.?-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes remove openjdk-?-jre-headless
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes remove mysql-server-core-?.?
sudo DEBIAN_FRONTEND=noninteractive apt-get  --yes --force-yes  remove unity-lens-shopping
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
wget http://haydenplanetarium.org/downloads/universe/linux/`echo $DUFILENAME`
unp `echo $DUFILENAME`

# download and decompress Nightshade 
# Nightshade is free, open source astronomy simulation and visualization software for teaching and exploring astronomy
echo "Downloading and decompressing Nightshade"
wget http://www.nightshadesoftware.org/attachments/download/6/`echo $NIGHTSHADEFILENAME`
unp `echo $NIGHTSHADEFILENAME`

# download and decompress scisoft utilities
echo "Downloading and decompressing scisoft utilities"
wget ftp://ftp.eso.org/scisoft/`echo $SCISOFTFILENAME`/linux/fedora11/tar/`echo $SCISOFTFILENAME`.tar.gz
unp `echo $SCISOFTFILENAME`

# download and compile skyviewer from http://lambda.gsfc.nasa.gov/toolbox/tb_skyviewer_ov.cfm
echo "Downloading and compiling skyviewer from nasa website"
wget http://lambda.gsfc.nasa.gov/toolbox/skyviewer/`echo $SKYVIEWERFILENAME`.tar.gz
unp `echo $SKYVIEWERFILENAME`.tar.gz
cd `echo $SKYVIEWERFILENAME`
sudo qmake
sudo make
sudo make install
cd ..

# download C2A Planetarium Software for Windows platform
echo "Downloading C2A Planetarium Software for Windows platform - use wine application"
wget http://www.astrosurf.com/c2a/english/download/`echo $C2AFILENAME`
unp `echo $C2AFILENAME`
wine setup.exe

# clean up current directory
echo "Performing file cleanup"
mv *.zip $ZIP
mv *.pdf $PDF
mv *.deb $DEB
mv *.km? $KMZ
mv *gz $TAR
rm *.exe

# install texlive the only proper way so that tlmgr also works correctly in Ubuntu 13.10 or Ubuntu 14.04 LTS
# procedure created on March 8, 2014:
# install-tl-ubuntu script requires 4GB of free diskspace

sudo DEBIAN_FRONTEND=noninteractive apt-get purge texlive-base texlive-binaries  texlive-fonts-recommended
sudo DEBIAN_FRONTEND=noninteractive apt-get purge  texlive-common texlive-doc-base texlive-latex-base texlive-publishers
git clone https://github.com/scottkosty/install-tl-ubuntu.git
cd install-tl-ubuntu
./install-tl-ubuntu --help

# following script tries to install Ubuntu package parallel which ONLY exists in Ubuntu 13.10 and Ubuntu 14.04 LTS
sudo bash install-tl-ubuntu 

sudo texhash
tlmgr init-usertree
tlmgr update --all
tlmgr install hyperref
sudo fmtutil-sys --all
sudo update-texmf


# install rstudio / R-Studio from source code:
# Free disk space required: around 5 GB
# Mac OS X users should use RStudio-0.98.501.dmg instead of R to avoid the following UNIX child process forking error:
# THE_PROCESS_HAS_FORKED_AND_YOU_CANNOT_USE_THIS_COREFOUNDATION_FUNCTIONALITY_YOU_MUST_EXEC__() to debug.

cd
git clone https://github.com/rstudio/rstudio.git
cd rstudio/
mkdir build
cd build/
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  libcurl4-gnutls-dev libboost-all-dev cmake libqt4-dev  build-essential libqtwebkit-dev

cd ~/rstudio/dependencies/common
bash install-common
cd

bash ~/rstudio/dependencies/linux/install-dependencies-debian
cd ~/rstudio/build
cmake .. -DRSTUDIO_TARGET=Desktop -DCMAKE_BUILD_TYPE=Release
sudo make
sudo make install
sudo ln -s /usr/local/lib/rstudio/bin/rstudio /usr/bin
cd


# install knitr (used by texmaker) from source code:
cd; rm knitr_*.tar.gz
git clone https://github.com/yihui/knitr.git
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes  install  r-base-core r-base
R CMD build knitr
R CMD INSTALL knitr_*.tar.gz
sudo cp ~/knitr/inst/bin/knit /usr/bin/knit
cd knitr
make check


###############################################################################################
#     Links for astronomers                                                                   #
###############################################################################################

echo "Please add these Astronomy bookmarks into all 5 webbrowsers (chromium, firefox, konqueror, chrome, opera)"
echo "http://www.gmail.com"
echo "http://arxiv.org/list/astro-ph/new"
# in arxiv.org: click on 'other' next to 'pdf' and choose to 'download source' using the axel command in a Terminal
# to examine the original .tex file which uses the aastex class
# decompress the extensionless source file using  the unp command
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
# following URL added on February 25, 2014:
echo "http://www.plos.org/publications/journals/"
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
#     Anti-NSA measures - PRISM Break anonymizing websites                                                        #
###############################################################################################
# following URL added on June 15, 2013:
echo "http://prism-break.org/"
# following URL added on January 21, 2014:
echo "https://startpage.com/"
# following URL added on June 15, 2013:
echo "http://www.opennicproject.org/nearest-servers/"
# following URL added on March 23, 2014:
echo "https://7.hidemyass.com"

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
# following URL added on February 26, 2014:



# following URL added on February 19, 2014:
# free guides
echo "http://onepager.togaware.com/"
# following URL added on March 25, 2014:
# R Reference Card 2.0
echo "http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf"
# following URL added on February 19, 2014:
echo "http://www.Rdocumentation.org"
# following URL added on February 19, 2014:
echo "http://www.r-bloggers.com/"
# following URL added on February 19, 2014:
echo "http://www.rstudio.com/"
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
# following URL added on March 7, 2014:
# Step 3 Sams Teach Yourself SQL in 10 Minutes (4th Edition)
echo "http://www.amazon.fr/Sams-Teach-Yourself-Minutes-Edition-ebook/dp/B009XDGF2C/ref=sr_1_1?ie=UTF8&qid=1394192160&sr=8-1&keywords=Sams+Teach+Yourself+SQL+in+10+Minutes+%284th+Edition%29"
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
# following URL added on March 29, 2014:
# search engine for R
echo "http://www.rseek.org/"
# following URL added on April 22, 2014:
# Cookbook for R
echo "http://www.cookbook-r.com/"


# R model generation and selection tools:

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
