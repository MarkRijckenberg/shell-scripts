# Procedure to copy mp3 files from Youtube playlist to Android smartphone
# Prerequisites: Linux, bash shell
mkdir ~/youtube-dl
rm ~/youtube-dl/youtube-dl
wget https://yt-dl.org/downloads/latest/youtube-dl -O ~/youtube-dl/youtube-dl
chmod +x ~/youtube-dl/youtube-dl

echo -n "Enter Youtube playlist to convert to mp3: " 
read url
playlistname=`~/youtube-dl/youtube-dl --flat-playlist --no-check-certificate  $url |grep download|head -n1|cut -d":" -f2`
playlistdir=$(echo $playlistname | tr -d ' '| tr -d '&')

mkdir ~/youtube-dl/$playlistdir
cd ~/youtube-dl/$playlistdir
~/youtube-dl/youtube-dl --no-check-certificate -v  --extract-audio --audio-format mp3 -i  $url

# then copy mp3 files to Android smartphone using AirDroid Android application
