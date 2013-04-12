# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily restore Ubuntu packages into a clean install of Lubuntu 12.04
# REQUIRES: Lubuntu 12.04, wget, apt-get, unp, wine
# Author: Mark Rijckenberg
# Copyright (c) 2012-08-12
# REVISION DATE: 20130410
# Updated by: markrijckenberg at gmail dot com
PATH=/usr/sbin:/usr/bin:/sbin:/bin
#Prerequisites: USB drives SAMSUNG and IOMEGA need to be mounted correctly in order for this script to work correctly!

#define source directories
HOME=/home/ulysses/
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

# refresh list of available packages in Ubuntu repositories
sudo apt-get update
# install list of packages defined in installedpackages file
sudo apt-get install  `cat  installedpackages`
# Cuttlefish is an ingenious little tool. It allows you to define a set of actions that occur when a certain stimulus is activated.
sudo add-apt-repository ppa:noneed4anick/cuttlefish
sudo apt-get update
sudo apt-get install cuttlefish 
# libdvdcss2, to play encrypted DVDs
sudo apt-get install libdvdcss2 && sudo /usr/share/doc/libdvdread4/./install-css.sh
# Install Ubuntu Tweak to easily uninstall old kernel versions
sudo add-apt-repository ppa:tualatrix/ppa
sudo apt-get update
sudo apt-get install ubuntu-tweak
# install razor-qt desktop environment
sudo add-apt-repository ppa:razor-qt/ppa
sudo apt-get update
sudo apt-get install razorqt razorqt-desktop

###############################################################################################
#     WEBBROWSERS SECTION                                                                     #
###############################################################################################

# install Google Chrome browser which has better support for Flash websites (Youtube, ...)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
sudo dpkg -i google-chrome*.deb
# fix the Google Chrome dependencies issue
sudo apt-get -f install
# install Opera browser
wget -O- http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get install opera
# uninstall Java due to all the critical security issues in 2013
sudo apt-get remove java-common

###############################################################################################
#     ASTRONOMY SECTION                                                                       #
###############################################################################################
# install casapy-upstream-binary  - Common Astronomy Software Applications package provided by NRAO, python bindings
sudo add-apt-repository --yes ppa:aims/casapy
sudo apt-get update
sudo apt-get install casapy-upstream-binary

# install Google Earth
wget http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.deb
sudo dpkg -i google-earth-stable_current_i386.deb

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

# download and decompress Digital Universe and Partiview Resources
echo "Downloading and decompressing Digital Universe and Partiview Resources"
wget http://haydenplanetarium.org/downloads/universe/linux/DUv3_9pview.tgz
unp DUv3_9pview.tgz

# download and decompress Nightshade 
# Nightshade is free, open source astronomy simulation and visualization software for teaching and exploring astronomy
echo "Downloading and decompressing Nightshade"
wget http://www.nightshadesoftware.org/attachments/download/6/nightshade-11.12.1.tar.gz
unp nightshade-11.12.1.tar.gz

# download and decompress scisoft utilities
echo "Downloading and decompressing scisoft utilities"
wget ftp://ftp.eso.org/scisoft/scisoft7.7.0/linux/fedora11/tar/scisoft-7.7.0.tar.gz
unp scisoft-7.7.0.tar.gz

# download American Astronomical Society manuscript preparation guidelines 
echo "Downloading American Astronomical Society manuscript preparation guidelines"
wget http://ctan.mackichan.com/macros/latex/contrib/aastex/docs/aasguide.pdf
mv aasguide.pdf American_Astronomical_Society_guidelines.pdf

# download Users Guide to Writing a Thesis in Physics Astronomy Institute of the University of Bonn
echo "Downloading Users Guide to Writing a Thesis in Physics Astronomy Institute of the University of Bonn"
wget http://www-biblio.physik.uni-bonn.de/info/downloads/thesis_guide.pdf
mv thesis_guide.pdf bonn_thesis_writing_guide_latex_march_31_2013.pdf

# download The Not So Short Introduction to LaTeX2e by Tobias Oetiker et alii
echo "Downloading The Not So Short Introduction to LaTeX2e by Tobias Oetiker et alii"
wget http://tobi.oetiker.ch/lshort/lshort.pdf
mv lshort.pdf latex2-not-so-short-introduction.pdf

# download C2A Planetarium Software for Windows platform
echo "Downloading C2A Planetarium Software for Windows platform - use wine application"
wget http://www.astrosurf.com/c2a/english/download/c2a_full_2_0_49.zip
unp c2a_full_2_0_49.zip
wine setup.exe

# clean up current directory
echo "Cleaning up current work directory..."
mv *.zip $ZIP
mv *.pdf $PDF
mv *.deb $DEB
mv *.km? $KMZ
mv *gz $TAR
rm *.exe

echo "Please add these Astronomy bookmarks into all 5 webbrowsers (chromium, firefox, konqueror, chrome, opera)"
echo "http://www.gmail.com"
echo "http://arxiv.org/archive/astro-ph"
echo "http://adsabs.harvard.edu/abstract_service.html"
echo "http://en.wikipedia.org/wiki/List_of_nearest_stars"
echo "http://www.wolframalpha.com/input/?i=astronomy&a=*C.astronomy-_*ExamplePage-"
echo "http://en.wikipedia.org/wiki/Star_catalogue#Successors_to_USNO-A.2C_USNO-B.2C_NOMAD.2C_UCAC_and_Others"
echo "http://ned.ipac.caltech.edu/"
echo "http://www.aanda.org/"
echo "http://www.usno.navy.mil/USNO/astrometry/information/catalog-info/catalog-information-center-1#usnob1"
echo "http://www.usno.navy.mil/USNO/astrometry/optical-IR-prod/icas/fchpix"
echo "http://be.kompass.com/live/fr/w2866018/edition-livres/edition-livres-astronomie-geodesie-meteorologie-1.html#.UV1dCqA9RZc"
echo "http://www.ctan.org/topic/astronomy"
echo "http://en.wikibooks.org/wiki/LaTeX"
echo "http://www.ottobib.com/"
echo "http://www.krantenkoppen.be/"
echo "Also get MIPAV imaging tool here:  http://mipav.cit.nih.gov/download.php"
echo "Check with book publisher in which format the digitized book needs to be sent to the publisher (preferably latex instead of Word, ODF, hybrid PDF-ODF format, etc...)"
echo "Use texmaker Ubuntu package with AASTeX special macros (aastex is part of texlive-publishers package) to write new Astronomy book"
