#!/bin/bash
#Ubuntu backup script - 2012-08-12 - Mark Rijckenberg - version 1.0
# Version 2.0 - 2015-10-11
PATH=/usr/sbin:/usr/bin:/sbin:/bin

#Prerequisites: 
# USB drives SAMSUNG and IOMEGA need to be mounted correctly in order for this script to work correctly!
# https://github.com/MarkRijckenberg/rsync-time-backup.git

#define source directories
HOMEUSER=`whoami`
HOME=/home/`cat $HOMEUSER`/
SOURCE2=/etc/
SOURCE3=/media/windows/rsync/

#define target directories where backup will be stored
TARGET1=/media/SAMSUNG/$HOME/
TARGET2=/media/IOMEGA/$HOME/
TARGET7=/media/`cat $HOMEUSER`/BACKUP/$HOME/

TARGET3=/media/SAMSUNG/etc/
TARGET4=/media/IOMEGA/etc/
TARGET8=/media/`cat $HOMEUSER`/BACKUP/etc/

TARGET5=/media/SAMSUNG/media/windowsdata/rsync/
TARGET6=/media/IOMEGA/media/windowsdata/rsync/

sudo apt-get update
sudo apt-get install -y dselect rsync
sudo dpkg --get-selections > Package.list
sudo cp Package.list $TARGET1/Package.list
sudo cp Package.list $TARGET2/Package.list
sudo cp Package.list $TARGET3/Package.list
sudo cp Package.list $TARGET4/Package.list
sudo cp Package.list $TARGET5/Package.list
sudo cp Package.list $TARGET6/Package.list
sudo cp Package.list $TARGET7/Package.list
sudo cp Package.list $TARGET8/Package.list

sudo apt-key exportall > Repo.keys
sudo cp Repo.keys $TARGET1/Repo.keys
sudo cp Repo.keys $TARGET2/Repo.keys
sudo cp Repo.keys $TARGET3/Repo.keys
sudo cp Repo.keys $TARGET4/Repo.keys
sudo cp Repo.keys $TARGET5/Repo.keys
sudo cp Repo.keys $TARGET6/Repo.keys
sudo cp Repo.keys $TARGET7/Repo.keys
sudo cp Repo.keys $TARGET8/Repo.keys

sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $HOME $TARGET1
sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $HOME $TARGET2
sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $HOME $TARGET7

sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $SOURCE2 $TARGET3
sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $SOURCE2 $TARGET4
sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $SOURCE2 $TARGET8

sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $SOURCE3 $TARGET5
sudo $HOME/rsync-time-backup/rsync_tmbackup.sh $SOURCE3 $TARGET6

