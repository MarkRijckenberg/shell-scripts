#Ubuntu backup script - 2012-08-12 - Mark Rijckenberg - version 1.0
PATH=/usr/sbin:/usr/bin:/sbin:/bin

#Prerequisites: USB drives SAMSUNG and IOMEGA need to be mounted correctly in order for this script to work correctly!

#define source directories
HOME=/home/ulysses/
SOURCE2=/etc/
SOURCE3=/media/windows/rsync/

#define target directories where backup will be stored
TARGET1=/media/SAMSUNG/$HOME/
TARGET2=/media/IOMEGA/$HOME/
TARGET3=/media/SAMSUNG/etc/
TARGET4=/media/IOMEGA/etc/
TARGET5=/media/SAMSUNG/media/windowsdata/rsync/
TARGET6=/media/IOMEGA/media/windowsdata/rsync/
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $HOME $TARGET1
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $HOME $TARGET2
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $SOURCE2 $TARGET3
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $SOURCE2 $TARGET4
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $SOURCE3 $TARGET5
#sudo /usr/bin/rsync -quvra   --exclude='.*' --exclude "$HOME.gvfs"  --max-size='100M' $SOURCE3 $TARGET6

sudo apt-get update
sudo apt-get install -y dselect rsync
#sudo dpkg --get-selections > $TARGET1/Package.list
#sudo dpkg --get-selections > $TARGET2/Package.list
#sudo dpkg --get-selections > $TARGET3/Package.list
#sudo dpkg --get-selections > $TARGET4/Package.list
#sudo dpkg --get-selections > $TARGET5/Package.list
#sudo dpkg --get-selections > $TARGET6/Package.list
sudo dpkg --get-selections > Package.list

#sudo apt-key exportall > $TARGET1/Repo.keys
#sudo apt-key exportall > $TARGET2/Repo.keys
#sudo apt-key exportall > $TARGET3/Repo.keys
#sudo apt-key exportall > $TARGET4/Repo.keys
#sudo apt-key exportall > $TARGET5/Repo.keys
#sudo apt-key exportall > $TARGET6/Repo.keys
sudo apt-key exportall > Repo.keys
