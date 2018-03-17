# Procedure to copy mp3 files from Youtube playlist to Android smartphone
# Prerequisites: Ubuntu 17.10 or Ubuntu 18.04, bash shell, mp3gain

#VARIABLES
TOOL=youtube-dl
INSTALLDIR=~/$TOOL

# install mp3gain (if not installed)
if ! type "mp3gain" > /dev/null; then
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository --yes ppa:flexiondotorg/audio
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install --yes --force-yes   aacgain mp3gain
  else
  echo "mp3gain installed"
fi

mkdir $INSTALLDIR
rm $INSTALLDIR/$TOOL
wget https://yt-dl.org/downloads/latest/$TOOL -O $INSTALLDIR/$TOOL
chmod +x $INSTALLDIR/$TOOL

echo -n "Enter Youtube playlist to convert to mp3: " 
read URL
PLAYLISTNAME=`$INSTALLDIR/$TOOL --flat-playlist --no-check-certificate  $URL | egrep "Downloading playlist" | head -n1 | cut -d":" -f2`
PLAYLISTDIR=$(echo $PLAYLISTNAME | tr -d ' '| tr -d '&')

mkdir $INSTALLDIR/$PLAYLISTDIR
cd $INSTALLDIR/$PLAYLISTDIR
$INSTALLDIR/$TOOL --postprocessor-args "-threads 6" --no-check-certificate -v  --extract-audio --audio-format mp3 -i  $URL
# normalize volume
mp3gain
mp3gain -r -T *.mp3

# then copy mp3 files to Android smartphone using AirDroid Android application
