#!/bin/bash
# Required software: CUDA 6.5, in order to be able to compile truecrack 3.6 source code from Github.com
# afterwards WITH Nvidia graphics card support
# Required GNU/Linux distribution: Ubuntu 14.04 LTS 64-bit
# Required free disk space: at least 5 gigabytes free disk space on your root (/) partition
# last update: January 6, 2016
sudo rm /etc/apt/trusted.gpg.d/*
sudo apt purge openjdk-6-jre openjdk-7-jre-headless openjdk-7-jre java-common
sudo rm -rf /etc/java-*-openjdk/*
sudo apt update
sudo apt install unp build-essential checkinstall wget apt default-jdk git cmake pkg-config
# Install cuda 8 first:
cd /tmp
rm -rf cuda*
#wget --no-check-certificate   https://developer.nvidia.com/cuda-downloads
#URL=`grep 1404 cuda-downloads |head -n 1|cut -d"'" -f8`
#VERSION=`grep 1404 cuda-downloads |head -n 1|cut -d"'" -f8|cut -d"_" -f3|cut -d"-" -f1`
##wget `echo $URL`
wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb
sudo dpkg -i --force-all cuda*deb
sudo apt update
sudo apt install libopencv-core-dev checkinstall
sudo apt install libopencv-flann-dev libopencv-imgproc-dev libopencv-dev
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
# Then install truecrack v3.6:
cd
rm list
rm truecrack*
git clone https://github.com/lvaccaro/truecrack.git
cd true*
# use following ./configure line , if you do NOT have an Nvidia graphics card that supports CUDA:
sudo ./configure --enable-cpu
# use following ./configure line instead, if you DO have an Nvidia graphics card that supports CUDA:
# sudo ./configure 
sudo make
sudo checkinstall
# Before building and installing the truecrack package, make sure to first set the 'Version' value to 3.6 during checkinstall configuration
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
#Version: 3.6-1
#Provides: truecrack
#Description: Package created with checkinstall 1.6.2
#Description-md5: 556b8d22567101c7733f37ce6557412e
truecrack

sudo apt install  build-essential libfftw3-dev libX11-dev libxt-dev libxaw7-dev phylip
sudo apt install  python-bs4 python-networkx python-skimage python-sklearn libpng-dev libfreetype6-dev
sudo apt install  python-matplotlib python-numpy python-pandas libprotobuf-dev libleveldb-dev libsnappy-dev
sudo apt install  python3-matplotlib python3-numpy python3-pandas libhdf5-serial-dev protobuf-compiler
sudo apt install  python-jsonschema openbox python-scipy pandoc libatlas-base-dev libboost-all-dev
sudo apt install  libgflags-dev libgoogle-glog-dev liblmdb-dev python3-dev python3-scipy kate
# use pip command from python-pip package to install pip packages for python 2.7
# use pip3 command from python3-pip package to install pip packages for python3+
sudo apt install  spyder unp python-pip python3-pip build-essential python-dev swig
sudo apt install  python-mpltoolkits.basemap-data python-mpltoolkits.basemap  libopencv-dev

# install newest version of ipython notebook:
sudo apt remove  ipython ipython-notebook python-tornado
sudo apt install  ipython3 ipython3-notebook python-simplegeneric python3-simplegeneric python3-pip
sudo pip install --upgrade pip
sudo pip install --upgrade ipython tornado 

sudo pip install --upgrade setuptools seaborn
sudo pip install --upgrade beautifulsoup4 numpy scipy matplotlib argparse
sudo pip install --upgrade mistune networkx pandas py4j runipy socli
sudo pip install --upgrade scikit-image scikit-learn scipy-data_fitting
sudo pip install --upgrade statsmodels jsonschema pattern instantmusic

#source: https://github.com/tensorflow/tensorflow/blob/master/tensorflow/g3doc/get_started/os_setup.md#pip-installation
# Ubuntu/Linux 64-bit, CPU only:
#######sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
# Ubuntu/Linux 64-bit, GPU enabled:
# sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl

sudo pip install --upgrade git+git://github.com/tensorflow/skflow.git
