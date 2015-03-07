# Required software: CUDA 6.5, in order to be able to compile truecrack 3.5 source code afterwards WITH Nvidia graphics card support
# Required GNU/Linux distribution: Ubuntu 14.04 LTS 64-bit
# Required free disk space: at least 5 gigabytes free disk space on your root (/) partition
sudo rm /etc/apt/trusted.gpg.d/*
sudo apt-get purge openjdk-6-jre openjdk-7-jre-headless openjdk-7-jre
sudo rm -rf /etc/java-7-openjdk/*
sudo apt-get update
sudo apt-get install unp build-essential checkinstall wget aptitude
# Install cuda 6.5 first:
cd /tmp
rm -rf cuda*
wget --no-check-certificate   https://developer.nvidia.com/cuda-downloads
URL=`grep 1404 cuda-downloads |grep x86_64|head -n 1|cut -d"\"" -f4`
VERSION=`grep 1404 cuda-downloads |grep x86_64|head -n 1|cut -d"\"" -f4|cut -d"_" -f3|cut -d"-" -f1`
wget `echo $URL`
sudo dpkg -i --force-all cuda*.deb
sudo aptitude update
sudo aptitude install cuda nvidia-cuda-dev libopencv-core-dev 
sudo aptitude install libopencv-flann-dev libopencv-imgproc-dev libopencv-dev
export PATH=/usr/local/cuda-`echo $VERSION`/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-`echo $VERSION`/lib64:$LD_LIBRARY_PATH
echo "export PATH=/usr/local/cuda-`echo $VERSION`/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-`echo $VERSION`/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
cd /usr/local/cuda-`echo $VERSION`/samples
# Next compilation step will take at least 30 minutes:
# Have a cup of coffee :-)
sudo ln -s /usr/local/cuda-`echo $VERSION` /usr/local/cuda
sudo make
# Check if you have a graphics card that supports CUDA :
/usr/local/cuda-`echo $VERSION`/samples/bin/x86_64/linux/release/deviceQuery
/usr/local/cuda-`echo $VERSION`/samples/bin/x86_64/linux/release/bandwidthTest
# Then install truecrack v3.5:
cd /tmp
rm list
rm truecrack*
wget --no-check-certificate https://code.google.com/p/truecrack/downloads/list
FILENAME=`grep gz list|head -n 1 | cut -d"\"" -f2|cut -d"/" -f5`
wget --no-check-certificate truecrack.googlecode.com/files/`echo $FILENAME`
unp truecrack*
cd true*
# use following ./configure line , if you do NOT have an Nvidia graphics card that supports CUDA:
sudo ./configure --enable-cpu
# use following ./configure line instead, if you DO have an Nvidia graphics card that supports CUDA:
# sudo ./configure 
sudo make
sudo checkinstall
# Before building and installing the truecrack package, make sure to first set the 'Version' value to 3.5 during checkinstall configuration
# checkinstall will fail to build the package if you do not set a valid Version first
# Verify that truecrack is correctly installed:
apt-cache show truecrack
#Package: truecrack
#Status: install ok installed
#Priority: extra
#Section: checkinstall
#Installed-Size: 276
#Maintainer: root
#Architecture: amd64
#Version: 3.5-1
#Provides: truecrack
#Description: Package created with checkinstall 1.6.2
#Description-md5: 556b8d22567101c7733f37ce6557412e
truecrack

sudo apt-get install  python-networkx python-skimage python-sklearn
sudo apt-get install  python-matplotlib python-numpy python-pandas
sudo apt-get install  python-jsonschema openbox
sudo apt-get install  spyder unp python-pip build-essential
sudo pip install --upgrade networkx
sudo pip install --upgrade scikit-image
sudo pip install --upgrade scikit-learn
sudo pip install --upgrade matplotlib
sudo pip install --upgrade numpy
sudo pip install --upgrade pandas
sudo pip install --upgrade runipy
sudo pip install --upgrade jsonschema
sudo pip install --upgrade mistune

