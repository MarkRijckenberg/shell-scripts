#! /usr/bin/env bash

# Prerequisites: Mac OS X 10.10.4 or newer, git, Xcode 7.0.1 or newer (=Apple CLI Dev tools)

# 1) minimum version of Mac OS X required to install latest Xcode: https://en.wikipedia.org/wiki/Xcode
# 2) install git using this FAQ:
# http://sourceforge.net/projects/git-osx-installer/files/
# then clone this Github repository to your local home directory

# 3) install Xcode 7.0.1 or newer via this link:
# https://developer.apple.com/xcode/

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
sudo ln -s Current 1.8

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
#brew install brew-cask

brew upgrade
#brew upgrade brew-cask
brew doctor #should say "Your system is ready to brew."

brew cask fetch java
brew cask install java
brew cask install xquartz #Pre-req for some of the brew packages

brew install python --framework
brew install putty gtk+

brew install ack

# upgrade bash shell:
brew install bash
sudo sh -c 'echo "/usr/local/bin/bash" >> /etc/shells'
chsh -s /usr/local/bin/bash
sudo mv /bin/bash /bin/bash-backup
sudo ln -s /usr/local/bin/bash /bin/bash

brew install byacc
brew install cabextract
brew install coreutils
brew install emacs --cocoa
brew install findutils
brew install fish
brew install flex
brew install gawk
brew install gcc
brew install git
brew install gnu-sed
brew install go
#brew install ispell
brew install jdiskreport
brew install --HEAD --64bit julia
brew install kdiff3
#brew install lua52
#brew install mercurial
#brew install minicom
#brew install multimarkdown
#brew install mutt
brew install node
brew install offline-imap
brew install p7zip
brew install python
# brew install sqlite
brew install ssh-copy-id
#brew install svn
#brew install the_silver_searcher
#brew install tmux
brew install wget
brew install wine
brew install winetricks
#brew install z

brew cask install 4k-youtube-to-mp3
#brew cask install adium
#brew cask install adobe-air 
#brew cask install adobe-reader
#brew cask install anki
#brew cask install arduino
brew cask install atom
#brew cask install bartender
brew cask install caffeine
brew cask install calibre
brew cask install ccleaner
brew cask install chromium
brew cask install citrix-receiver
#brew cask install chicken
#brew cask install controlplane
brew cask install dash
#brew cask install dropbox
brew cask install dupeguru
#brew cask install eclipse-ide
brew cask install evernote
brew cask install filezilla
brew cask install firefox
brew cask install flash
brew cask install flip4mac
#brew cask install flux
#brew cask install freeplane
#brew cask install fritzing
brew cask install gimp
brew cask install gnucash
brew cask install google-chrome
#brew cask install google-drive
brew cask install google-earth
#brew cask install gpgtools
#brew cask install iterm2
brew cask install jdiskreport
brew cask install kdiff3
#brew cask install keepassx0
brew cask install kindle
#brew cask install legacy-keepassx
brew cask install libreoffice
#brew cask install mactex
#brew cask install macvim
#brew cask install minecraft
#brew cask install music-manager
#brew cask install openscad
brew cask install paintbrush
#brew cask install quicksilver
brew cask fetch r
brew cask install r
#brew cask install second-life-viewer
#brew cask install sketchup
brew cask install skype
#brew cask install slic3r
#brew cask install smcfancontrol
#brew cask install sourcetree
#brew cask install steam
brew cask install stellarium
brew cask fetch teamviewer
brew cask install teamviewer
#brew cask install the-unarchiver
#brew cask install thunderbird
brew cask install transmission
#brew cask install truecrypt71a
brew cask install unrarx
#brew cask install vagrant
brew cask install virtualbox
brew cask install vlc
# brew cask install vmware-fusion
brew cask install xbmc

brew cleanup
brew cask cleanup

# Install Perlbrew

sudo cpan App::perlbrew
perlbrew init
source $HOME/perl5/perlbrew/etc/bashrc
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

brew install numpy
brew install scipy
brew install matplotlib

#Make Fish your default shell:
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# remove ruby 1.8 symbolic link used for finding ruby in Mac OS X 10.10 or newer:
sudo rm /System/Library/Frameworks/Ruby.framework/Versions/1.8
