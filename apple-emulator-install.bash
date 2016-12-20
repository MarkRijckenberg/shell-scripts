#!/bin/bash
# Apple IIe emulator
sudo apt-get update
sudo apt-get install git unp build-essential checkinstall
cd
sudo rm -rf apple2
git clone https://github.com/mauiaaron/apple2.git
cd ~/apple2
cp Makefile.am Makefile
sudo ./configure
sudo make
sudo checkinstall
wget --no-check-certificate  http://www.applelogic.org/files/PRODOSUM.pdf
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/apple_iie_rom.zip
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/077-0018%20Apple%20IIe%20Diagnostic%20Card%20-%20English%20-%20Lower%20ROM%202764.bin
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/077-0019%20Apple%20IIe%20Diagnostic%20Card%20-%20English%20-%20Upper%20ROM%202764.bin
wget --no-check-certificate  ftp://ftp.apple.asimov.net/pub/apple_II/emulators/rom_images/2764_APPLE-IIe-0341-0162-A_PAL_SWE_FIN.bin
# get newest ProDOS 2.4.1 operating system for Apple IIe (release date: September 2016!)
wget --no-check-certificate https://archive.org/download/ProDOS_2_4_1/ProDOS_2_4_1.dsk
cp ProDOS_2_4_1.dsk ~/apple2/disks/
unp apple*.zip
