#!/bin/bash
# Required software: CUDA 8.0 or newer, in order to be able to compile truecrack 3.6 source code from Github.com
# afterwards WITH Nvidia graphics card support
# Required GNU/Linux distribution: Ubuntu 17.10 64-bit
# Required free disk space: at least 5 gigabytes free disk space on your root (/) partition
# last update: January 13, 2018
VERSION=9.0
sudo rm /etc/apt/trusted.gpg.d/*
sudo apt purge openjdk-6-jre openjdk-7-jre-headless openjdk-7-jre java-common
sudo rm -rf /etc/java-*-openjdk/*
sudo apt update
sudo apt install unp build-essential checkinstall wget apt default-jdk git cmake pkg-config virtualenv
# Install cuda 8 first:
cd /tmp
rm -rf cuda*
#wget --no-check-certificate   https://developer.nvidia.com/cuda-downloads
#URL=`grep 1404 cuda-downloads |head -n 1|cut -d"'" -f8`
#VERSION=`grep 1404 cuda-downloads |head -n 1|cut -d"'" -f8|cut -d"_" -f3|cut -d"-" -f1`
##wget `echo $URL`
wget https://developer.nvidia.com/compute/cuda/`echo $VERSION`/Prod/local_installers/cuda-repo-ubuntu1704-9-0-local_`echo $VERSION`.176-1_amd64-deb
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
#sudo ./configure --enable-cpu
# use following ./configure line instead, if you DO have an Nvidia graphics card that supports CUDA:
sudo ./configure 
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

#source: https://github.com/tensorflow/tensorflow/blob/master/tensorflow/g3doc/get_started/os_setup.md#pip-installation
# Ubuntu/Linux 64-bit, CPU only:
#######sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
# Ubuntu/Linux 64-bit, GPU enabled:
# sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl

# sudo pip install --upgrade tensorflow-gpu
# sudo pip install --upgrade git+git://github.com/tensorflow/skflow.git

# install miniconda3 (in classic Ubuntu install or in Qubes AppVM):
# miniconda3 is compatible with spyder, python3.6+ and conda
cd
rm Miniconda*.sh
rm -rf miniconda*
wget  --no-check-certificate  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3*.sh

##########################################################################
# exit Terminal and open new Terminal before running following commands:
##########################################################################
# Never use pip to install spyder application.
# never use pip to upgrade python packages to avoid corrupting spyder install
# Instead, use conda to install spyder application.
# Only use conda in combination with spyder and python3.6+
##########################################################################
conda install anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip
conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip
conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip
conda install jupyter 
conda install dvc
conda install ipython 
conda install tornado 
conda install setuptools 
conda install seaborn
conda install beautifulsoup4 
conda install argparse
conda install sklearn 
conda install streamlink
conda install mistune 
conda install networkx 
conda install py4j 
conda install runipy 
conda install socli
conda install scikit-image 
conda install scikit-learn 
conda install scipy-data_fitting
conda install statsmodels 
conda install jsonschema 
# do not install pattern package, because it causes severe downgrade of anaconda
# and python package versions: conda install pattern 
conda install instantmusic
conda install fire 
conda install boto3 
conda install mock 
conda install pytest 
conda install pytest-mock 
conda install bcolz 
conda install configobj 
conda install ipywidgets 
conda install nibabel 
conda install Pillow-SIMD 
conda install qgrid 
conda install tqdm 
conda install traitlets 
conda install visdom 
conda install filelock 
conda install spectral 
conda install elasticsearch 
# following package requires at least 700 MB of free disk space:
# conda config --add channels conda-forge
# conda install tensorflow-gpu
# conda install tensorflow
# conda install tensorfx
# conda install keras

REM Check if all dependencies are installed by inspecting

REM Spyder/Help/Dependencies window in Spyder application

