# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily install new GNU/Linux kernels. The script should be copied to /usr/bin/installkernel and set as executable.
# REQUIRES: ksh, Ubuntu 12.04 LTS or newer
# REVISED: 20130323
# Copyright (c) 2012  Savvas Radevic <vicedar@gmail.com>
# Updated by: markrijckenberg@gmail.com

sudo apt-get update
sudo apt-get install python-bs4
cd /tmp
rm -rf medigeek-kmp*
wget --no-check-certificate https://github.com/medigeek/kmp-downloader/tarball/master -O kmpd.tar.gz
tar xzf kmpd.tar.gz
cd medigeek-*
python kmpd.py -d
