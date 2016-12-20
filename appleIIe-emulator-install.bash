#!/bin/bash
# Apple IIe emulator
sudo apt-get update
sudo apt-get install git unp build-essential checkinstall libopenal-dev 
sudo apt-get install freeglut3-dev gawk libsdl1.2-dev libcurl4-openssl-dev zlib1g-dev libzip-dev
cd
sudo rm -rf apple2
sudo rm -rf linapple
# git clone https://github.com/mauiaaron/apple2.git
git clone https://github.com/timob/linapple.git
cd ~/linapple/src
sudo make
cd ..
# Get ProDOS User Guide
wget --no-check-certificate  http://www.applelogic.org/files/PRODOSUM.pdf
# Get Apple IIe ROM
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/apple_iie_rom.zip
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/077-0018%20Apple%20IIe%20Diagnostic%20Card%20-%20English%20-%20Lower%20ROM%202764.bin
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/077-0019%20Apple%20IIe%20Diagnostic%20Card%20-%20English%20-%20Upper%20ROM%202764.bin
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/2764_APPLE-IIe-0341-0162-A_PAL_SWE_FIN.bin
# get newest ProDOS 2.4.1 operating system for Apple IIe (release date: September 2016!)
wget --no-check-certificate https://archive.org/download/ProDOS_2_4_1/ProDOS_2_4_1.dsk
# get Apple II games
wget --no-check-certificate  http://www.virtualapple.org/apple2/Breakout_Chipout_Hi-Res_Breakout.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Galaxian.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/SantaParaviaandFiumaccio.zip
unp *.zip
mv *.dsk ~/apple2/disks/
sudo make clean
cp Makefile.am Makefile
cp configure.ac configure
./reconf.sh
sudo ./configure
sudo make
sudo checkinstall

