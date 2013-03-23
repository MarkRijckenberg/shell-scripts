# TYPE: Korn Shell script.
# PURPOSE: This korn shell script allows to easily remove GNU/Linux kernels. The script should be copied to /usr/bin/removekernel and set as executable. It is a poor man's alternative to Ubuntu Tweak.
# REQUIRES: ksh, Ubuntu 12.04 LTS or newer
# REVISED: 20130302
# AUTHOR: markrijckenberg@gmail.com

if [[ $1 == "" ]]; then
echo "List of installed kernel versions:"
dpkg --list | grep linux-image | grep '^ri' | cut -d" " -f3
echo "No argument added after removekernel command"
echo "Please enter kernelversion to remove from your pc (for example: 2.6.24-16) "
read KERNELVERSION

echo "Removing kernelversion $KERNELVERSION"
apt-cache search $KERNELVERSION|cut -d" " -f1|xargs sudo apt-get remove -y

else
echo "Removing kernelversion $1"
apt-cache search $1|cut -d" " -f1|xargs sudo apt-get remove -y
fi
