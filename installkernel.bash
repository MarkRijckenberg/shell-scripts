#!/bin/bash
# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily install new GNU/Linux kernels. The script should be copied to /usr/bin/installkernel and set as executable.
# REQUIRES: bash, Ubuntu 12.04 LTS 32-bit or Ubuntu 12.10 32-bit or Ubuntu 13.04 32-bit
# Copyright (c) 2012  Savvas Radevic <vicedar@gmail.com>
# REVISED: 20130323
# Updated by: markrijckenberg@gmail.com

sudo apt-get update
sudo apt-get install python-bs4
cd /tmp
rm -rf medigeek-kmp*
wget --no-check-certificate https://github.com/medigeek/kmp-downloader/tarball/master -O kmpd.tar.gz
tar xzf kmpd.tar.gz
cd medigeek-*
python kmpd.py -d
