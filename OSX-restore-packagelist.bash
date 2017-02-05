#! /usr/bin/env bash

# Prerequisites: Mac OS X El Sierra (version 10.12.2) or newer, git, Xcode 8.2.1 or newer (=Apple CLI Dev tools)
# Minimum free disk space to install Mac OS X and the applications below: 30 GB

# 1) minimum version of Mac OS X required to install latest Xcode: https://en.wikipedia.org/wiki/Xcode
# 2) install git using this FAQ:
# http://sourceforge.net/projects/git-osx-installer/files/
# then clone this Github repository to your local home directory

# 3) install Xcode via this link:
# https://itunes.apple.com/be/app/xcode/id497799835?mt=12

# 4) execute the bash script below

defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# sudo nvram SystemAudioVolume=" "


# Install Apple CLI Dev tools, java and my preferred homebrew and cask software
# xcode-select --install # Works on Mavericks and hopefully above
# echo
# read -p "Please wait until CLI tools are installed and press enter"  < /dev/tty

# Make sure ruby binary can be found in Mac OS X 10.10 or newer:
cd /System/Library/Frameworks/Ruby.framework/Versions
# sudo ln -s Current 1.8

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Symlink into the normal place. Add this to login scripts as well
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

sudo xcodebuild -license

brew tap caskroom/cask
brew tap caskroom/versions
brew tap staticfloat/julia
brew tap samueljohn/python
brew tap homebrew/science

brew update
#brew reinstall brew-cask

brew upgrade
#brew upgrade brew-cask
brew doctor #should say "Your system is ready to brew."

brew cask fetch java
brew cask reinstall java
brew cask reinstall xquartz #Pre-req for some of the brew packages
brew reinstall python --framework
brew reinstall putty gtk+

brew reinstall ack

# upgrade bash shell:
brew reinstall bash
sudo sh -c 'echo "/usr/local/bin/bash" >> /etc/shells'
chsh -s /usr/local/bin/bash
sudo mv /bin/bash /bin/bash-backup
sudo ln -s /usr/local/bin/bash /bin/bash

brew reinstall byacc
brew reinstall cabextract
brew reinstall coreutils
brew reinstall emacs --with-cocoa
brew reinstall findutils
brew reinstall fish
brew reinstall flex
brew reinstall gawk
# brew reinstall gcc # requires Xcode CLT (command line tools) to be installed first
brew reinstall git
brew reinstall gnu-sed
brew reinstall go
#brew reinstall ispell
brew reinstall jdiskreport
brew reinstall --HEAD --64bit julia
brew reinstall kdiff3
#brew reinstall lua52
#brew reinstall mercurial
#brew reinstall minicom
#brew reinstall multimarkdown
#brew reinstall mutt
brew reinstall node
brew reinstall offline-imap
brew reinstall p7zip
brew reinstall python
# brew reinstall sqlite
brew reinstall ssh-copy-id
#brew reinstall svn
#brew reinstall the_silver_searcher
#brew reinstall tmux
brew reinstall wget
brew remove wine winetricks
brew cask reinstall wine-staging
#brew reinstall z

brew cask reinstall 4k-youtube-to-mp3
#brew cask reinstall adium
#brew cask reinstall adobe-air 
#brew cask reinstall adobe-reader
#brew cask reinstall anki
#brew cask reinstall arduino
brew cask reinstall atom
#brew cask reinstall bartender
brew cask reinstall caffeine
brew cask reinstall calibre
brew cask reinstall ccleaner
brew cask reinstall chromium
brew cask reinstall citrix-receiver
#brew cask reinstall chicken
#brew cask reinstall controlplane
brew cask reinstall dash
#brew cask reinstall dropbox
brew cask reinstall dupeguru
#brew cask reinstall eclipse-ide
brew cask reinstall evernote
brew cask reinstall filezilla
brew cask reinstall firefox
brew cask reinstall flash
brew cask reinstall flip4mac
#brew cask reinstall flux
#brew cask reinstall freeplane
#brew cask reinstall fritzing
brew cask reinstall gimp
brew cask reinstall gnucash
brew cask reinstall google-chrome
#brew cask reinstall google-drive
brew cask reinstall google-earth
#brew cask reinstall gpgtools
#brew cask reinstall iterm2
brew cask reinstall jdiskreport
brew cask reinstall kdiff3
#brew cask reinstall keepassx0
brew cask reinstall kindle
#brew cask reinstall legacy-keepassx
brew cask reinstall libreoffice
#brew cask reinstall mactex
#brew cask reinstall macvim
#brew cask reinstall minecraft
#brew cask reinstall music-manager
#brew cask reinstall openscad
brew cask reinstall paintbrush
#brew cask reinstall quicksilver
brew cask fetch r
brew cask reinstall r
brew cask reinstall rstudio
#brew cask reinstall second-life-viewer
#brew cask reinstall sketchup
brew cask reinstall skype
#brew cask reinstall slic3r
#brew cask reinstall smcfancontrol
#brew cask reinstall sourcetree
#brew cask reinstall steam
brew cask reinstall stellarium
brew cask fetch teamviewer
brew cask reinstall teamviewer
#brew cask reinstall the-unarchiver
#brew cask reinstall thunderbird
brew cask reinstall transmission
#brew cask reinstall truecrypt71a
brew cask reinstall unrarx
#brew cask reinstall vagrant
brew cask reinstall virtualbox
brew cask reinstall vlc
# brew cask reinstall vmware-fusion
# brew cask reinstall xbmc

brew cleanup
brew cask cleanup

# Install Perlbrew
curl -L https://install.perlbrew.pl | bash
# add following source line into ~/.bash_profile file:
source $HOME/perl5/perlbrew/etc/bashrc
# open new Terminal and run following commands:
# cpan App::perlbrew
perlbrew init
perlbrew install perl-stable
perlbrew install-cpanm
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
# cpanm install CPAN::Mini
# minicpan -l ~/perl5/minicpan -r http://mirror.internode.on.net/pub/cpan/


# Install keybase client (keybase.io)

npm install -g keybase-installer


#  Add local golang tools directory

#export GOPATH=/usr/local/gotools
#export GOBIN="$GOPATH/bin"
#mkdir "$GOPATH"
#echo "export GOPATH=\"\$PWD\"" >  $GOPATH/.envrc
#echo "export GOBIN=\"\$PWD/bin\"" >>  $GOPATH/.envrc
#direnv allow $GOPATH
#cd "$GOPATH""
#go get github.com/golang/lint/golint
#go get github.com/tools/godep
#go get code.google.com/p/go.tools/cmd/goimports
#echo Please add \"$GOBIN\" to your path

sudo easy_install pip
pip install --upgrade distribute
pip install --upgrade pip
# https://courses.edx.org/asset-v1:DelftX+EX101x+3T2015+type@asset+block/xlwingsguide.pdf
pip install --upgrade xlwings
pip install --upgrade nose
pip install --upgrade pyparsing
pip install --upgrade python-dateutil
pip install --upgrade pep8

brew reinstall numpy
brew reinstall scipy
brew reinstall homebrew/python/matplotlib

#Make Fish your default shell:
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# remove ruby 1.8 symbolic link used for finding ruby in Mac OS X 10.10 or newer:
sudo rm /System/Library/Frameworks/Ruby.framework/Versions/1.8
