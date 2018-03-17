# Procedure to copy mp3 files from Youtube playlist to Android smartphone
# Prerequisites: Ubuntu 17.10 or Ubuntu 18.04, bash shell, mp3gain, parallel (to use multi-core processors)
# Prerequisites: Google Chrome Web browser in Ubuntu, AirDroid on Android smartphone

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

# install parallel (if not installed)
if ! type "parallel" > /dev/null; then
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install --yes --force-yes   parallel
  else
  echo "parallel installed"
fi

mkdir $INSTALLDIR
rm $INSTALLDIR/$TOOL
wget https://yt-dl.org/downloads/latest/$TOOL -O $INSTALLDIR/$TOOL
chmod +x $INSTALLDIR/$TOOL

echo -n "Enter Youtube playlist to convert to mp3: " 
read URL
PLAYLISTNAME=`$INSTALLDIR/$TOOL --flat-playlist --no-check-certificate  $URL | egrep -v "just" | egrep "Downloading playlist" | head -n1 | cut -d":" -f2`
PLAYLISTDIR=$(echo $PLAYLISTNAME | tr -d ' '| tr -d '&')

mkdir $INSTALLDIR/$PLAYLISTDIR
cd $INSTALLDIR/$PLAYLISTDIR
$INSTALLDIR/$TOOL --postprocessor-args "-threads 6" --no-check-certificate -v  --extract-audio --audio-format mp3 -i  $URL
# normalize volume (run 3 times in case mp3gain skips treatment of files during first 2 attempts)
find . -type f | parallel -X "xargs mp3gain -r -T"
find . -type f | parallel -X "xargs mp3gain -r -T"
find . -type f | parallel -X "xargs mp3gain -r -T"

echo "Temporarily disable all extensions in Google Chrome webbrowser and reboot your Android smartphone before attempting the .mp3 file transfer from Ubuntu to Android via AirDroid"
echo "The Mozilla Firefox web browser is not (yet) compatible with AirDroid. You have to use Google Chrome."
