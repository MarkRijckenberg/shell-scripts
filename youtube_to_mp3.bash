# Procedure to copy mp3 files from Youtube playlist to Android smartphone
# Prerequisites: Ubuntu 17.10 or Ubuntu 18.04, bash shell, mp3gain

# install mp3gain (if not installed)
if ! type "mp3gain" > /dev/null; then
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:flexiondotorg/audio
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install --yes --force-yes   aacgain mp3gain
  else
  echo "mp3gain installed"
fi

mkdir ~/youtube-dl
rm ~/youtube-dl/youtube-dl
wget https://yt-dl.org/downloads/latest/youtube-dl -O ~/youtube-dl/youtube-dl
chmod +x ~/youtube-dl/youtube-dl

echo -n "Enter Youtube playlist to convert to mp3: " 
read url
playlistname=`~/youtube-dl/youtube-dl --flat-playlist --no-check-certificate  $url | egrep "Downloading playlist" | head -n1 | cut -d":" -f2`
playlistdir=$(echo $playlistname | tr -d ' '| tr -d '&')

mkdir ~/youtube-dl/$playlistdir
cd ~/youtube-dl/$playlistdir
~/youtube-dl/youtube-dl --postprocessor-args "-threads 6" --no-check-certificate -v  --extract-audio --audio-format mp3 -i  $url
# normalize volume
mp3gain -r -T *.mp3

# then copy mp3 files to Android smartphone using AirDroid Android application
