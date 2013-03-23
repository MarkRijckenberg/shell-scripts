sudo apt-get update
sudo apt-get install python-bs4
cd /tmp; rm -rf medigeek-kmp*; wget --no-check-certificate https://github.com/medigeek/kmp-downloader/tarball/master -O kmpd.tar.gz; tar xzf kmpd.tar.gz; cd medigeek-*; python kmpd.py -d
