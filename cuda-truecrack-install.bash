# Required software: CUDA 6.5, in order to be able to compile truecrack 3.5 source code afterwards WITH Nvidia graphics card support
# Required GNU/Linux distribution: Ubuntu 14.04 LTS 64-bit
# Required free disk space: at least 5 gigabytes free disk space on your root (/) partition
sudo apt-get update
sudo apt-get install unp build-essential checkinstall wget
# Install cuda 6.5 first:
cd /tmp
rm cuda-downloads
wget --no-check-certificate   https://developer.nvidia.com/cuda-downloads
URL=`grep 1404 cuda-downloads |grep x86_64|head -n 1|cut -d"\"" -f4`
VERSION=`grep 1404 cuda-downloads |grep x86_64|head -n 1|cut -d"\"" -f4|cut -d"_" -f3|cut -d"-" -f1`
wget `echo $URL`
sudo dpkg -i cuda*.deb
sudo apt-get update
sudo apt-get install cuda
export PATH=/usr/local/cuda-`echo $VERSION`/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-`echo $VERSION`/lib64:$LD_LIBRARY_PATH
echo "export PATH=/usr/local/cuda-`echo $VERSION`/bin:$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-`echo $VERSION`/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
cd /usr/local/cuda-`echo $VERSION`/samples
# Next compilation step will take at least 30 minutes:
# Have a cup of coffee :-)
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
#Maintainer: root@ulysses-Latitude-E6500
#Architecture: amd64
#Version: 3.5-1
#Provides: truecrack
#Description: Package created with checkinstall 1.6.2
#Description-md5: 556b8d22567101c7733f37ce6557412e
truecrack

