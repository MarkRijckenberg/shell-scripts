#!/bin/bash
# Apple IIe emulator
sudo apt-get update
sudo apt-get install git unp build-essential checkinstall libopenal-dev 
sudo apt-get install freeglut3-dev gawk libsdl1.2-dev libcurl4-openssl-dev zlib1g-dev libzip-dev
cd
sudo rm -rf apple2
sudo rm -rf linapple
# git clone https://github.com/mauiaaron/apple2.git
# git clone https://github.com/timob/linapple.git
git clone https://github.com/LasDesu/linapple.git
mkdir ~/linapple/disks
cd ~/linapple/src
sudo make
cd ~/linapple
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
wget --no-check-certificate  http://www.virtualapple.org/apple2/AliBaba.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/AppleInvaders_GalaxyWars_Invasion_StellarInv_SuperInv.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Aztec.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/BATTLEZONE.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Bilestoad,The.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/CastleWolfenstein\(fixed\).zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/ChampionshipLodeRunner.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Choplifter.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/DawnPatrol.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Defender.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Decathalon.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/DinoEggs.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Frogger.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Galaxian.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/HardHatMack.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Hi-ResBreakout.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/Karateka.zip
wget --no-check-certificate  http://www.virtualapple.org/apple2/SantaParaviaandFiumaccio.zip
unp *.zip
mv *.dsk ~/linapple/disks/
~/linapple/linapple
# Press F3 in linapple and navigate to ~/linapple/disks and select the game to load
# Then press CTRL-SHIFT-F2 to restart the linapple emulator and load the game
