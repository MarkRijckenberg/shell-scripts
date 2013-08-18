# !!!!! WINDOWS users should use ninite.com for semi-automated Windows application deployments
# and http://treexy.com/products/driver-fusion.aspx for system driver updates
# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily restore Ubuntu packages into a clean install of Ubuntu 12.10
# REQUIRES: Ubuntu 12.10 LTS 64-bit (to support UEFI+SecureBoot+biber+bibtex), wget, apt-get, unp, wine, biber, biblatex
# REQUIRED FREE DISKSPACE FOR BASEPACKAGES:  7 GB of free disk space in root partition
# INSTALL DURATION: Around 1h30min
# Author: Mark Rijckenberg
# Copyright (c) 2012-08-12
# REVISION DATE: 20130521
# Updated by: markrijckenberg at gmail dot com
PATH=/usr/sbin:/usr/bin:/sbin:/bin
#Prerequisites: USB drives SAMSUNG and IOMEGA need to be mounted correctly in order for this script to work correctly!

MACHINE_TYPE=`uname -m`

# define basepackage filename variables - VERSION NUMBERS FREQUENTLY CHANGE!!
TEXSTUDIOFILENAME="texstudio_2.6.2"
SKYPEFILENAME="skype-ubuntu-precise_4.2.0.11-1_i386.deb"
YEDFILENAME="yEd-3.11_32-bit_setup.sh"
FOURKFILENAME="4kvideodownloader_2.7-1"

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
#sudo apt-get install dselect rsync -y
#sudo apt-key add $TARGET1/Repo.keys
sudo apt-key add Repo.keys
#sudo dpkg --set-selections < $TARGET1/Package.list
#sudo dpkg --set-selections < Package.list
#sudo dselect

#sudo cp /etc/apt/sources.list  /etc/apt/sources.list.backup
#sudo cp sources.list.12.04 /etc/apt/sources.list

###############################################################################################
#     BASE PACKAGES SECTION                                                                   #
###############################################################################################

# refresh list of available packages in Ubuntu repositories
sudo apt-get update
# install list of packages defined in packages files
# allpackages = basepackages + astropackages
# sudo apt-get --yes --force-yes install `cat  allpackages` -o APT::Install-Suggests="false"
sudo apt-get  install  `cat  basepackages` -o APT::Install-Suggests="false"

#install i-nex - I-nex is similar to CPU-Z in Windows, it uses the same interface to display your hardware information.
sudo add-apt-repository --yes ppa:i-nex-development-team/daily
sudo add-apt-repository --yes  ppa:nemh/gambas3
sudo apt-get update
sudo apt-get  --yes --force-yes  install i-nex 

# install google-talkplugin
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get  --yes --force-yes  install google-talkplugin
# Install TLP - advanced power management command line tool for Linux
sudo add-apt-repository --yes ppa:linrunner/tlp
sudo apt-get update
sudo apt-get --yes --force-yes install tlp tlp-rdw

# Install kazam screen recording tool for Ubuntu 12.04 / 12.10 / 13.04
sudo add-apt-repository --yes ppa:kazam-team/stable-series
sudo apt-get update
sudo apt-get --yes --force-yes install kazam

# install hotshots Screen Capture Tool In Ubuntu 12.04 / 12.10 / 13.04
sudo apt-add-repository --yes ppa:dhor/myway
sudo apt-get update
sudo apt-get --yes --force-yes install hotshots

# install Final Term - excellent Terminal emulator in  Ubuntu 12.04 / 12.10 / 13.04
sudo apt-add-repository --yes ppa:finalterm/daily
sudo apt-get update
sudo apt-get --yes --force-yes install finalterm

# install kdenlive video editor
sudo apt-add-repository --yes  ppa:philip5/extra
sudo apt-get update
sudo apt-get --yes --force-yes install kdenlive

# Install openshot which is a simple and easy to use video editor, like a good substitute for the windows movie maker
sudo apt-add-repository --yes ppa:openshot.developers/ppa
sudo apt-get update
sudo apt-get --yes --force-yes install openshot

# install desurium game client
sudo apt-add-repository --yes ppa:makson96/desurium
sudo apt-get update
sudo apt-get --yes --force-yes install desurium

# install 64-bit compatible Steam client
wget -c media.steampowered.com/client/installer/steam.deb
sudo dpkg -i steam.deb
sudo apt-get  --yes --force-yes  install -f 
 
# Install razorqt desktop environment
sudo add-apt-repository --yes ppa:razor-qt/ppa
sudo apt-get update
sudo apt-get --yes --force-yes install razorqt razorqt-desktop

# install kde desktop environment
#sudo add-apt-repository --yes  ppa:kubuntu-ppa/backports
#sudo apt-get update
#sudo apt-get  --yes --force-yes   install kubuntu-desktop

# Cuttlefish is an ingenious little tool. It allows you to define a set of actions that occur when a certain stimulus is activated.
sudo add-apt-repository --yes ppa:noneed4anick/cuttlefish
sudo apt-get update
sudo apt-get --yes --force-yes install cuttlefish 

# Install Ubuntu Tweak to easily uninstall old kernel versions
sudo add-apt-repository --yes ppa:tualatrix/ppa
sudo apt-get update
sudo apt-get --yes --force-yes install ubuntu-tweak

# Install newest version of VLC player
sudo add-apt-repository --yes ppa:videolan/stable-daily
sudo apt-get update
sudo apt-get --yes --force-yes install vlc

# install skype
sudo apt-get remove skype skype-bin
wget http://download.skype.com/linux/`echo $SKYPEFILENAME`
sudo dpkg -i skype-ubuntu*.deb
sudo apt-get -f install

# install Y PPA Manager
sudo add-apt-repository --yes ppa:webupd8team/y-ppa-manager
sudo apt-get update
sudo apt-get --yes --force-yes install  y-ppa-manager

# libdvdcss2, to play encrypted DVDs
sudo apt-get --yes --force-yes install libdvdcss2
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
sudo apt-get --yes --force-yes -f install

# install 4kyoutubetomp3 - extremely fast Youtube playlist downloader
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
sudo apt-get --yes --force-yes -f install

# install Google Earth
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
sudo dpkg -i google-earth-stable_current_amd64.deb
sudo apt-get --yes --force-yes -f install
# install Teamviewer server + client
wget http://download.teamviewer.com/download/teamviewer_linux_x64.deb
sudo dpkg -i teamviewer_linux_x64.deb
sudo apt-get --yes --force-yes -f install
# install newest wine version 
sudo add-apt-repository ppa:ubuntu-wine/ppa 
sudo apt-get update
sudo apt-get install wine1.6 winetricks wine1.6-amd64
else
  # 32-bit stuff here
# install Google Chrome browser which has better support for Flash websites (Youtube, ...)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
sudo dpkg -i google-chrome*.deb
# fix the Google Chrome dependencies issue
sudo apt-get --yes --force-yes -f install

# install 4kyoutubetomp3 - extremely fast Youtube playlist downloader
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
sudo apt-get --yes --force-yes -f install

# install Google Earth
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb
sudo dpkg -i google-earth-stable_current_i386.deb
sudo apt-get --yes --force-yes -f install
# install Teamviewer server + client
wget http://download.teamviewer.com/download/teamviewer_linux.deb
sudo dpkg -i teamviewer_linux.deb
sudo apt-get --yes --force-yes -f install
# install newest wine version 
sudo add-apt-repository ppa:ubuntu-wine/ppa 
sudo apt-get update
sudo apt-get install wine1.6-i386
sudo apt-get install wine1.6 winetricks
fi

# install Opera browser
wget -O- http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get --yes --force-yes install opera

# install Multimedia codecs
sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update
sudo apt-get --yes --force-yes install non-free-codecs libdvdcss

# install Realplayer (latest version is from 2009)
#sudo apt-get update && sudo apt-get install lsb
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
sudo apt-get --yes --force-yes remove java-common
sudo apt-get --yes --force-yes remove default-jre
sudo apt-get --yes --force-yes remove gcj-?.?-jre-headless
sudo apt-get --yes --force-yes remove openjdk-?-jre-headless
sudo apt-get remove mysql-server-core-?.?
sudo apt-get remove unity-lens-shopping
sudo apt-get autoclean
sudo apt-get clean
sudo rm /etc/apt/sources.list.d/*
grep -v opera /etc/apt/sources.list  > /tmp/sources.list
sudo cp /tmp/sources.list  /etc/apt/sources.list

# Install yEd editor 
# (powerful desktop application that can be used to quickly and effectively generate high-quality diagrams)
# Save diagrams in .pdf format so they can be included as graphics in a new latex document in texmaker
wget http://www.yworks.com/products/yed/demo/`echo $YEDFILENAME`
sh `echo $YEDFILENAME`

###############################################################################################
#     ASTRONOMY SOFTWARE SECTION                                                              #
###############################################################################################

sudo apt-get install  `cat  astropackages` -o APT::Install-Suggests="false"

# install texlive 2012.201206 packages (will upgrade texlive 2009 to texlive 2012.201206 in Ubuntu 12.04)
sudo add-apt-repository  --yes ppa:texlive-backports/ppa
sudo apt-get update
sudo apt-get --yes --force-yes  install texlive-full biblatex biber


# install casapy-upstream-binary  - Common Astronomy Software Applications package provided by NRAO, python bindings
sudo add-apt-repository --yes ppa:aims/casapy
sudo apt-get update
sudo apt-get --yes --force-yes install casapy-upstream-binary

sudo add-apt-repository --yes ppa:olebole/astro-quantal
sudo apt-get update
sudo apt-get --yes --force-yes install casacore 
sudo apt-get --yes --force-yes install cpl
sudo apt-get --yes --force-yes install esorex
# download and decompress SAOImage DS9 software
sudo apt-get --yes --force-yes install saods9 
sudo apt-get --yes --force-yes install sextractor 


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
wget http://sourceforge.net/projects/skychart/files/1-%20cdc-skychart/version_3.8/skychart_3.8-2450_amd64.deb
sudo dpkg -i skychart_3.8-2450_amd64.deb
sudo apt-get -f install
sudo apt-get --yes --force-yes install  texmaker
#install texstudio
TEXSTUDIOREMOTEDIR="http://download.opensuse.org/repositories/home:/jsundermeyer/xUbuntu_12.10/amd64/"
url=$(wget -O- -q --no-check-certificate `echo $TEXSTUDIOREMOTEDIR` |  sed -ne 's/^.*"\([^"]*texstudio[^"]*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $TEXSTUDIOREMOTEDIR``echo $url`
# Install the package
sudo dpkg -i `echo $url`
# Clean up
rm `echo $url`
cd
rm -rf "$dir"
cd
sudo apt-get -f install

else
  # 32-bit stuff here
# download and decompress IRAF - Image Reduction and Analysis Facility, a general purpose
# software system for the reduction and analysis of astronomical data
echo "Downloading and decompressing IRAF - Image Reduction and Analysis Facility"
wget ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86.tar.gz
unp iraf.lnux.x86.tar.gz
echo "Downloading and installing skychart"
wget http://sourceforge.net/projects/skychart/files/1-%20cdc-skychart/version_3.8/skychart_3.8-2450_i386.deb
sudo dpkg -i skychart_3.8-2450_i386.deb
sudo apt-get -f install
sudo apt-get --yes --force-yes install   texmaker
#install texstudio
TEXSTUDIOREMOTEDIR="http://download.opensuse.org/repositories/home:/jsundermeyer/xUbuntu_12.10/i386/"
url=$(wget -O- -q --no-check-certificate `echo $TEXSTUDIOREMOTEDIR` |  sed -ne 's/^.*"\([^"]*texstudio[^"]*\.deb\)".*/\1/p' | sort -r | head -1) 
# Create a temporary directory
dir=$(mktemp -dt)
cd "$dir"
# Download the .deb file
wget `echo $TEXSTUDIOREMOTEDIR``echo $url`
# Install the package
sudo dpkg -i `echo $url`
# Clean up
rm `echo $url`
cd
rm -rf "$dir"
cd
sudo apt-get -f install

fi

wget http://sourceforge.net/projects/skychart/files/2-catalogs/Stars/skychart-data-stars_3.8-2293_all.deb
sudo dpkg -i skychart-data-stars_3.8-2293_all.deb
sudo apt-get -f install

wget http://sourceforge.net/projects/skychart/files/2-catalogs/Nebulea/skychart-data-dso_3.8-2293_all.deb
sudo dpkg -i skychart-data-dso_3.8-2293_all.deb
sudo apt-get -f install

wget http://sourceforge.net/projects/skychart/files/2-catalogs/Nebulea/skychart-data-pictures_3.1-1466_all.deb
sudo dpkg -i skychart-data-pictures_3.1-1466_all.deb
sudo apt-get -f install


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
sudo apt-get --yes --force-yes remove java-common
sudo apt-get --yes --force-yes remove default-jre
sudo apt-get --yes --force-yes remove gcj-?.?-jre-headless
sudo apt-get --yes --force-yes remove openjdk-?-jre-headless
sudo apt-get remove mysql-server-core-?.?
sudo apt-get remove unity-lens-shopping
sudo apt-get autoclean
sudo apt-get clean
sudo rm /etc/apt/sources.list.d/*
grep -v opera /etc/apt/sources.list  > /tmp/sources.list
sudo cp /tmp/sources.list  /etc/apt/sources.list

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


###############################################################################################
#     SHOW INTERESTING WEBBROWSER BOOKMARKS                                                   #
###############################################################################################

echo "Please add these Astronomy bookmarks into all 5 webbrowsers (chromium, firefox, konqueror, chrome, opera)"
echo "http://www.gmail.com"
echo "http://arxiv.org/list/astro-ph/new"
# in arxiv.org: click on 'other' next to 'pdf' and choose to 'download source' using the axel command in a Terminal
# to examine the original .tex file which uses the aastex class
# decompress the extensionless source file using  the unp command
echo "http://adsabs.harvard.edu/abstract_service.html"
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
###########AFTER VISIT TO GERARD ON JUNE 16 2013 ##############################################
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
echo "http://simbad.u-strasbg.fr/Simbad"
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

###############################################################################################
#     PRISM Break anonymizing websites                                                        #
###############################################################################################
# following URL added on June 15, 2013:
echo "http://prism-break.org/"
# following URL added on June 15, 2013:
echo "https://duckduckgo.com"
# following URL added on June 15, 2013:
echo "http://www.opennicproject.org/nearest-servers/"

echo "Check with book publisher in which format the digitized book needs to be sent to the publisher (preferably latex instead of Word, ODF, hybrid PDF-ODF format, etc...)"
echo "Use texstudio Ubuntu package with AASTeX special macros (aastex is part of texlive-publishers package)"
echo "to write new Astronomy book"
echo "get bibliography citations at http://www.ottobib.com  using ISBN number and convert info to bibtex plain text .bib file for use in Latex document"
echo "get bibliography citations at http://scholar.google.be using full title and author and choose import to bibtex"
echo "For example use - filetype:pdf author:'h karttunen'  -  as search term in http://scholar.google.be"
echo "For example use - site:arxiv.org intext:"habitable zone" - as search term in http://www.google.be/"
echo "Get more information about latex package by using command   texdoc <packagename> , for example: texdoc graphicx"

