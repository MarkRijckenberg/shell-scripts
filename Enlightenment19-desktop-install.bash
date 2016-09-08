#!/bin/bash

#~ NINETEEN.SH
#~ This script allows you to easily install/update Enlightenment 19 git
#~ (development version) on Ubuntu 14.04.2 LTS, or remove E19 git
#~ from your system.

#~ Once installed, you can update your Enlightenment desktop whenever you
#~ want to——I do this on a daily basis. However, I recommend completely
#~ uninstalling and reinstalling E19 every three weeks or so for a
#~ better user experience.

#~ Tip:
#~ Get the Faenza and Faience icon sets for your enlightened desktop
#~ before running the script.
#~ See http://www.noobslab.com/2014/06/faience-and-faenza-icons-for.html

#~ To execute the script:
#~ 1. Open Terminal (set scrollback to unlimited in profile preferences)
#~ 2. Change to the download folder
#~ 3. Make the script executable with chmod +x
#~ 4. Run it with ./nineteen.sh

#~ Warning:
#~ Enlightenment programs installed from .deb packages (or tarballs) will
#~ inevitably conflict with E19 programs compiled from git source code——
#~ do NOT mix source code with precompiled binaries!

#~ Written and signed by Philippe Jean Guillaumie (batden@sfr.fr).
#~ Feel free to use this script as you see fit.

#~ For more information, please visit our forum thread at:
#~ http://ubuntuforums.org/showthread.php?t=2274982

#~ Changelog:
#~ 2014-05-22 add warning.
#~ 2014-05-24 add libbluetooth-dev to dependencies.
#~ 2014-05-26 add link to ubuntuforums.
#~ 2014-05-31 do not disable connman module.
#~ 2014-06-01 add themes folder for elementary.
#~ 2014-06-02 add targets to deep_clean function.
#~ 2014-06-05 add linux-tools to bin_deps function.
#~ 2014-06-07 update noobslab link.
#~ 2014-08-06 add grive detection.
#~ 2014-08-13 add recommendation.
#~ 2014-08-19 add more targets to deep_clean function.
#~ 2014-09-16 add option to egrep.
#~ 2014-10-02 add comments.
#~ 2014-10-04 add option to elementary build.
#~ 2014-10-06 suppress unwanted error output.
#~ 2014-10-07 disable broken systray module.
#~ 2014-10-18 add even more targets to deep_clean function.
#~ 2014-10-31 add detection of conflicting .deb packages.
#~ 2014-11-11 add one more target to deep_clean function.
#~ 2014-12-15 add one more target to deep_clean function.
#~ 2014-12-17 add one more target to deep_clean function.
#~ 2014-12-20 add option for compiler cache removal.
#~ 2014-12-21 this script is now distributed as a digitally signed file.
#~ 2015-01-05 cosmetic changes.
#~ 2015-02-11 add more targets to deep_clean function.
#~ 2015-02-19 bump ubuntu version.
#~ 2015-03-13 add one more target to deep_clean function.
#~ 2015-03-24 add more targets to deep_clean function.
#~ 2015-04-04 add one more target to deep_clean function.
#~ 2015-04-07 maximize gnome terminal.
#~ 2015-04-09 add more targets to deep_clean function.
#~ 2015-04-12 do not enable i18n support by default.
#~ 2015-04-13 add debugging function.
#~ 2015-04-18 improve debug efficiency.
#~ 2015-04-20 add comment.
#~ 2015-04-21 more comments.
#~ 2014-04-22 add libxkbfile-dev and linux-tools-common to dependencies.
sudo apt-get update
sudo apt-get install zenity

trap '{ printf "\n$bdr%s $off%s\n\n" " KEYBOARD INTERRUPT."; exit 130; }' INT

#~ VARIABLES
bld="\e[1m"     #~ Bold text.
bdr="\e[1;31m"  #~ Bold red text.
bdg="\e[1;32m"  #~ Bold green text.
bdy="\e[1;33m"  #~ Bold yellow text.
off="\e[0m"     #~ Turn off ansi colors.

export CPPFLAGS=-I/usr/local/include
export LDFLAGS=-L/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export CC="ccache gcc"
export CXX="ccache g++"

NCPU="$(getconf _NPROCESSORS_ONLN)"
NJOBS="$((NCPU*2))"
export MAKE="make -j $NJOBS"

PREFIX=/usr/local
E19="$HOME/Enlightenment19"
TITLE="wmctrl -r :ACTIVE: -N"
GEN="./autogen.sh --prefix=$PREFIX"
RELEASE=$(lsb_release -sc)
CODE=$(locale | grep LANGUAGE | cut -d= -f2 | cut -d_ -f1)
DROPB="https://dl.dropboxusercontent.com/u/"

DOCUDIR=$(test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && \
source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
echo ${XDG_DOCUMENTS_DIR:-$HOME})

DEPS_EN="aspell-$CODE manpages imagemagick xserver-xephyr \
manpages-dev automake autopoint build-essential ccache \
check cowsay doxygen freeglut3-dev git libasound2-dev \
libblkid-dev libbluetooth-dev libbullet-dev libfontconfig1-dev \
libfreetype6-dev libfribidi-dev libgif-dev libglib2.0-dev \
libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
libharfbuzz-dev libiconv-hook-dev libjpeg-dev libblkid-dev \
libluajit-5.1-dev libmount-dev libpam0g-dev \
libpng12-dev libpoppler-dev libpulse-dev libraw-dev librsvg2-dev \
libsndfile1-dev libspectre-dev libssl-dev libtiff5-dev libtool \
libudev-dev libudisks2-dev libunibreak-dev libvlc-dev libwebp-dev \
libxcb-shape0-dev libxcb-keysyms1-dev libxcomposite-dev \
libxcursor-dev libxine-dev libxinerama-dev libxkbfile-dev \
libxp-dev libxrandr-dev libxss-dev libxtst-dev \
linux-tools-common ragel valgrind wmctrl"

TRIM_EN=${DEPS_EN:46}

DEPS="aspell-$CODE manpages.$CODE imagemagick xserver-xephyr \
manpages-dev manpages-$CODE-dev manpages-$CODE-extra automake \
autopoint build-essential ccache check cowsay doxygen freeglut3-dev \
git libasound2-dev libblkid-dev libbluetooth-dev libbullet-dev \
libfontconfig1-dev libfreetype6-dev libfribidi-dev \
libgif-dev libglib2.0-dev libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev libharfbuzz-dev libiconv-hook-dev \
libjpeg-dev libblkid-dev libluajit-5.1-dev libmount-dev \
libpam0g-dev libpng12-dev libpoppler-dev libpulse-dev libraw-dev \
librsvg2-dev libsndfile1-dev libspectre-dev libssl-dev libtiff5-dev \
libtool libudev-dev libudisks2-dev libunibreak-dev libvlc-dev \
libwebp-dev libxcb-shape0-dev libxcb-keysyms1-dev libxcomposite-dev \
libxcursor-dev libxine-dev libxinerama-dev libxkbfile-dev libxp-dev \
libxrandr-dev libxss-dev libxtst-dev linux-tools-common ragel \
valgrind wmctrl"

TRIM=${DEPS:48}

CLONEFL="git clone git://git.enlightenment.org/core/efl.git"
CLONEVL="git clone git://git.enlightenment.org/core/evas_generic_loaders.git"
CLONEGP="git clone git://git.enlightenment.org/core/emotion_generic_players.git"
CLONELM="git clone git://git.enlightenment.org/core/elementary.git"
CLONE19="git clone git://git.enlightenment.org/core/enlightenment.git"
CLONETY="git clone git://git.enlightenment.org/apps/terminology.git"

EPROG="efl evas_generic_loaders emotion_generic_players elementary 
enlightenment terminology"

#~ TESTS
if [ -x /usr/bin/wmctrl ]; then
    wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
fi

printf "\n$bld%s $off%s\n" "SYSTEM REQUIREMENTS CHECK..."; sleep 1

if [ $RELEASE == trusty ]; then
    printf "\n$bdg%s $off%s\n\n" "Ubuntu $RELEASE... OK"; sleep 1
else
    printf "\n$bdr%s $off%s\n\n" " UNSUPPORTED VERSION."
    exit 1
fi

dpkg -l | egrep -w 'e17|enlightenment' &>/dev/null
if [ $? == 0 ]; then
    printf "\n$bdr%s $off%s\n" " ANOTHER VERSION OF ENLIGHTENMENT IS INSTALLED."
    printf "$bdr%s $off%s\n\n" " SCRIPT ABORTED."
    exit 1
fi

if [ "$(pidof enlightenment)" ]; then
    printf "\n$bdr%s $off%s\n\n" " 
 PLEASE LOG IN TO UBUNTU TO EXECUTE THIS SCRIPT."
    exit 1
fi

#~ FUNCTIONS
warn () {
zenity --no-wrap --info --text "
If you proceed with the installation,\n\
nearly 1.5 GB of additional disk space\n\
will be used.\n
Bear in mind that running other applications\n\
during the build process will affect\n\
compilation time.\n
Have fun!"
}

beep_exit () {
canberra-gtk-play --id="suspend-error" &>/dev/null
}

beep_ok () {
canberra-gtk-play --id="complete" &>/dev/null
}

bin_deps ()  {
sudo apt-get update && sudo apt-get dist-upgrade --yes

if [ ! -f $DOCUDIR/installed.txt ]; then
    dpkg --get-selections > $DOCUDIR/installed.txt
    sed -i '/linux-generic*/d' $DOCUDIR/installed.txt
    sed -i '/linux-headers*/d' $DOCUDIR/installed.txt
    sed -i '/linux-image*/d' $DOCUDIR/installed.txt
    sed -i '/linux-signed*/d' $DOCUDIR/installed.txt
    sed -i '/linux-tools*/d' $DOCUDIR/installed.txt
fi

if [ $CODE == en ]; then
    sudo apt-get install --yes $DEPS_EN
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n" " CONFLICTING .DEB PACKAGES."
            printf "$bdr%s $off%s\n\n" " SCRIPT ABORTED."
            exit 1
        fi
else
    sudo apt-get install --yes $DEPS
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n" " CONFLICTING .DEB PACKAGES."
            printf "$bdr%s $off%s\n\n" " SCRIPT ABORTED."
            exit 1
        fi
fi
}

ls_ppa () {
PPA=$(awk '$1 == "Package:" { print $2 }' \
/var/lib/apt/lists/*ppa*Packages)

for I in $(echo $PPA | xargs -n1 | sort -u); do
    dpkg-query -Wf'${db:Status-abbrev}' $I &>/dev/null
        if [ $? == 0 ]; then
            sed -i "/$I/d" $DOCUDIR/installed.txt
        fi
done
}

ls_dir () {
COUNT=$(ls -d */ | wc -l)

if [ $COUNT == 6 ]; then
    printf "$bdg%s $off%s\n\n" "
All programs have been downloaded successfully."
    sleep 2
elif [ $COUNT == 0 ]; then
    printf "\n$bdr%s $off%s\n\n" " 
 PLEASE CHECK YOUR NETWORK CONNECTION AND TRY AGAIN."
 #~ (Relaunch the script and select option #1)
    beep_exit
    exit 1
else
    printf "\n$bdy%s $off%s\n\n" " 
 WARNING: ONLY $COUNT OF 6 PROGRAMS HAVE BEEN DOWNLOADED."
    sleep 4
fi
}

build () {
for I in $EPROG; do
    $TITLE "Processing ${I^} . . ."
    cd $E19/$I
    printf "\n$bld%s $off%s\n\n" "Building $I..."
        case $I in
            efl) $GEN --enable-harfbuzz --enable-image-loader-webp \
            --enable-multisense --enable-xine --enable-xinput22
            ;;
            elementary) $GEN --enable-cxx-bindings
            ;;
            enlightenment) $GEN --enable-mount-eeze --disable-packagekit \
            --disable-systray --disable-wl-desktop-shell
            ;;
            *) $GEN
            ;;
        esac 
    echo
    make
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n\n" " BUILD ERROR——TRY AGAIN LATER."
            #~ (Relaunch the script at a later time and select option #1)
            rm -rf $E19/$I
            beep_exit
            exit 1
        fi
    sudo make install
    sudo ldconfig
done
}

build_no_nls () {
for I in $EPROG; do
    $TITLE "Processing ${I^} . . ."
    cd $E19/$I
    printf "\n$bld%s $off%s\n\n" "Building $I..."
        case $I in
            efl) $GEN --enable-image-loader-webp --enable-multisense \
            --enable-xine --enable-xinput22 --disable-harfbuzz --disable-nls
            ;;
            elementary) $GEN --enable-cxx-bindings --disable-nls
            ;;
            enlightenment) $GEN --enable-mount-eeze --disable-nls \
            --disable-packagekit --disable-systray --disable-wl-desktop-shell
            ;;
            *) $GEN
            ;;
        esac
    echo
    make
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n\n" " BUILD ERROR——TRY AGAIN LATER."
            #~ (Relaunch the script at a later time and select option #1)
            rm -rf $E19/$I
            beep_exit
            exit 1
        fi
    sudo make install
    sudo ldconfig
    echo
done
}

rebuild () {
for I in $EPROG; do
    $TITLE "Processing ${I^} . . ."
    cd $E19/$I
    printf "\n$bld%s $off%s\n\n" "Updating $I..."
    make distclean &>/dev/null
    git reset --hard &>/dev/null
    git pull
    echo
        case $I in
            efl) $GEN --enable-harfbuzz --enable-image-loader-webp \
            --enable-multisense --enable-xine --enable-xinput22
            ;;
            elementary) $GEN --enable-cxx-bindings
            ;;
            enlightenment) $GEN --enable-mount-eeze --disable-packagekit \
            --disable-systray --disable-wl-desktop-shell
            ;;
            *) $GEN
            ;;
        esac
    echo
    make
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n\n" " BUILD ERROR——TRY AGAIN LATER."
            #~ (Relaunch the script at a later time and select option #2)
            beep_exit
            exit 1
        fi
    sudo make install
    sudo ldconfig
    echo
done
}

rebuild_no_nls () {
for I in $EPROG; do
    $TITLE "Processing ${I^} . . ."
    cd $E19/$I
    printf "\n$bld%s $off%s\n\n" "Updating $I..."
    make distclean &>/dev/null
    git reset --hard &>/dev/null
    git pull
    echo
        case $I in
            efl) $GEN --enable-image-loader-webp --enable-multisense \
            --enable-xine --enable-xinput22 --disable-harfbuzz --disable-nls
            ;;
            elementary) $GEN --enable-cxx-bindings --disable-nls
            ;;
            enlightenment) $GEN --enable-mount-eeze --disable-nls \
            --disable-packagekit --disable-systray --disable-wl-desktop-shell
            ;;
            *) $GEN
            ;;
        esac
    echo
    make
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n\n" " BUILD ERROR——TRY AGAIN LATER."
            #~ (Relaunch the script at a later time and select option #2)
            beep_exit
            exit 1
        fi
    sudo make install
    sudo ldconfig
    echo
done
}

rebuild_for_debug () {
export LC_ALL=C
export CFLAGS="-g -ggdb3"
export CXXFLAGS="-g -ggdb3"

#~ (Temporary tweaks until next reboot)
sudo sysctl -w kernel.yama.ptrace_scope=0
ulimit -c unlimited
echo "/var/crash/core.%e.%p.%h.%t" | sudo tee /proc/sys/kernel/core_pattern

for I in $EPROG; do
    $TITLE "Processing ${I^} . . ."
    cd $E19/$I
    printf "\n$bdy%s $off%s\n\n" "Rebuilding $I with debug symbols..."
    make distclean &>/dev/null
    git reset --hard &>/dev/null
    git pull
    echo
        case $I in
            efl) $GEN --enable-image-loader-webp --enable-multisense \
            --enable-xine --enable-xinput22 --enable-valgrind \
            --disable-harfbuzz --disable-nls --with-tests=regular
            ;;
            elementary) $GEN --enable-cxx-bindings --enable-debug --disable-nls
            ;;
            enlightenment) $GEN --enable-mount-eeze --disable-nls \
            --disable-packagekit --disable-systray --disable-wl-desktop-shell
            ;;
            *) $GEN
            ;;
        esac
    echo
    make
        if [ $? -ne 0 ]; then
            printf "\n$bdr%s $off%s\n\n" " BUILD ERROR——TRY AGAIN LATER."
            #~ (Relaunch the script at a later time and select option #5)
            beep_exit
            exit 1
        fi
    sudo make install
    sudo ldconfig
    echo
done
}

remove () {
printf "\n$bld%s $off%s\n\n" "Cleaning $I..."
sudo make uninstall &>/dev/null
make maintainer-clean &>/dev/null
echo
}

deep_clean () {
printf "\n$bld%s $off%s\n\n" "Deeper cleaning..."; sleep 1

cd $E19
sudo rm -rf enlightenment/
sudo rm -rf elementary/
sudo rm -rf emotion_generic_players/
sudo rm -rf evas_generic_loaders/
sudo rm -rf terminology/
sudo rm -rf efl/
rm custom* &>/dev/null

cd $HOME
rm -rf Enlightenment19/
rm -rf .e/
rm -rf .elementary/
rm -rf .cache/efreet/
rm -rf .cache/evas_gl_common_caches/
rm -rf .config/terminology/

cd /usr/local/bin
sudo rm -rf ecore*

cd /usr/local/etc/
sudo rm -rf enlightenment/

cd /usr/local/include/
sudo rm -rf ecore*
sudo rm -rf ector*
sudo rm -rf edje*
sudo rm -rf eet*
sudo rm -rf eeze*
sudo rm -rf efl*
sudo rm -rf efreet*
sudo rm -rf eina*
sudo rm -rf eio*
sudo rm -rf eldbus*
sudo rm -rf elementary*
sudo rm -rf elocation*
sudo rm -rf elua*
sudo rm -rf embryo*
sudo rm -rf emile*
sudo rm -rf emotion*
sudo rm -rf enlightenment*
sudo rm -rf eo*
sudo rm -rf ephysics*
sudo rm -rf ethumb*
sudo rm -rf evas*

cd /usr/local/lib/
sudo rm -rf ecore*
sudo rm -rf edje*
sudo rm -rf eeze*
sudo rm -rf efl*
sudo rm -rf efreet*
sudo rm -rf elementary*
sudo rm -rf emotion*
sudo rm -rf enlightenment*
sudo rm -rf eo*
sudo rm -rf ephysics*
sudo rm -rf ethumb*
sudo rm -rf evas*
sudo rm -rf libecore*
sudo rm -rf libector*
sudo rm -rf libedje*
sudo rm -rf libeet*
sudo rm -rf libeeze*
sudo rm -rf libefl*
sudo rm -rf libefreet*
sudo rm -rf libeina*
sudo rm -rf libeio*
sudo rm -rf libeldbus*
sudo rm -rf libelementary*
sudo rm -rf libelocation*
sudo rm -rf libelua*
sudo rm -rf libembryo*
sudo rm -rf libemile*
sudo rm -rf libemotion*
sudo rm -rf libeo*
sudo rm -rf libeolian*
sudo rm -rf libephysics*
sudo rm -rf libethumb*
sudo rm -rf libevas*

cd /usr/local/lib/cmake/
sudo rm -rf Ecore*
sudo rm -rf Edje*
sudo rm -rf Eet*
sudo rm -rf Eeze*
sudo rm -rf Efl*
sudo rm -rf Efreet*
sudo rm -rf Eina*
sudo rm -rf Eio*
sudo rm -rf Eldbus*
sudo rm -rf Elementary*
sudo rm -rf Elua*
sudo rm -rf Emile*
sudo rm -rf Emotion*
sudo rm -rf Eo*
sudo rm -rf Ethumb*
sudo rm -rf Evas*

cd /usr/local/share/
sudo rm -rf dbus*
sudo rm -rf ecore*
sudo rm -rf edje*
sudo rm -rf eeze*
sudo rm -rf efreet*
sudo rm -rf elementary*
sudo rm -rf elua*
sudo rm -rf embryo*
sudo rm -rf emotion*
sudo rm -rf enlightenment*
sudo rm -rf eo*
sudo rm -rf ethumb*
sudo rm -rf evas*
sudo rm -rf terminology*

cd /usr/local/share/gdb/
sudo rm -rf auto-load/usr/local/lib/libeo*

cd /usr/share/
sudo rm -rf xsessions/enlightenment.desktop
cd unity-greeter/
sudo rm custom_enlightenment_badge.png &>/dev/null
cd ../dbus-1/services/
sudo rm -rf org.enlightenment.Efreet.service
sudo rm -rf org.enlightenment.Ethumb.service
echo
}

#~ SELECTION
INPUT=0
printf "\n$bld%s $off%s\n" "Please enter the number of your choice."

if [ $INPUT -lt 1 ]; then
    printf "\n$bld%s $off%s\n\n" "1. Install Enlightenment 19."
    printf "$bld%s $off%s\n\n" "2. Update my E19 installation."
    printf "$bld%s $off%s\n\n" "3. Uninstall E19 programs only."
    printf "$bld%s $off%s\n\n" "4. Uninstall E19 programs AND \
binary dependencies."
    printf "$bld%s $off%s\n" "5. Rebuild E19 for debugging"
    printf "$bld%s $off%s\n\n" "   (make sure default E theme is applied)."
    sleep 2
    printf "\n$bld%s $off%s\n\n" "— Or press Ctrl-C to quit."
    read INPUT
fi

#~ INSTALLATION
if [ $INPUT == 1 ]; then
    clear; printf "\n$bld%s $off%s\n\n" "
Proceeding to install Enlightenment 19..."
    canberra-gtk-play --id="window-attention" &>/dev/null
    warn 2>/dev/null; sleep 1

        if grep -q ppa /var/lib/apt/lists/*ppa* &>/dev/null; then
            bin_deps
            ls_ppa
        else
            unset -f ls_ppa
            bin_deps
        fi

    cd $HOME; mkdir -p $E19; cd $E19

    $TITLE "Downloading Source Code . . ."
    printf "\n$bld%s $off%s\n\n" "Fetching git code..."
    $CLONEFL; echo
    $CLONEVL; echo
    $CLONEGP; echo
    $CLONELM; echo
    $CLONE19; echo
    $CLONETY; echo

    ls_dir

    $TITLE "Processing Enlightenment Programs . . ."
    echo

    read -p "Build internationalization support in Enlightenment? [y/N] " answer
    case $answer in
        [yY] ) build; echo
        ;;
        [nN] ) build_no_nls; echo
        ;;
        *    ) build_no_nls; echo
        ;;
    esac

    printf "\n%s\n\n" "Almost done..."

    wget $DROPB/58695863/custom_enlightenment_badge.png &>/dev/null
    sudo cp -f custom_enlightenment_badge.png \
    /usr/share/unity-greeter &>/dev/null

    mkdir -p $HOME/.elementary/themes/

    sudo ln -sf \
    /usr/local/share/dbus-1/services/org.enlightenment.Ethumb.service \
    /usr/share/dbus-1/services/org.enlightenment.Ethumb.service

    sudo ln -sf \
    /usr/local/share/dbus-1/services/org.enlightenment.Efreet.service \
    /usr/share/dbus-1/services/org.enlightenment.Efreet.service

    sudo ln -sf /usr/local/share/xsessions/enlightenment.desktop \
    /usr/share/xsessions/enlightenment.desktop

    sudo updatedb
    beep_ok
    $TITLE "Installation Complete."
    echo; cowsay "That's All Folks!"; echo

#~ UPDATE
elif [ $INPUT == 2 ]; then
    clear; printf "\n$bld%s $off%s\n\n" "
Proceeding to update Enlightenment 19..."
    sleep 1

    printf "\n$bld%s $off%s\n\n" "Checking required Ubuntu packages..."
    if [ $CODE == en ]; then
        sudo apt-get install --yes $DEPS_EN
        sleep 1
    else
        sudo apt-get install --yes $DEPS
        sleep 1
    fi
    echo

    $TITLE "Processing Enlightenment Programs . . ."
    echo

    read -p "Build internationalization support in Enlightenment? [y/N] " answer
    case $answer in
        [yY] ) rebuild; echo
        ;;
        [nN] ) rebuild_no_nls; echo
        ;;
        *    ) rebuild_no_nls; echo
        ;;
    esac

    printf "\n%s\n\n" "Almost done..."

    cd $E19
    wget -nc $DROPB/58695863/custom_enlightenment_badge.png &>/dev/null
    sudo cp -f custom_enlightenment_badge.png \
    /usr/share/unity-greeter &>/dev/null

    mkdir -p $HOME/.elementary/themes/

    sudo ln -sf \
    /usr/local/share/dbus-1/services/org.enlightenment.Ethumb.service \
    /usr/share/dbus-1/services/org.enlightenment.Ethumb.service

    sudo ln -sf \
    /usr/local/share/dbus-1/services/org.enlightenment.Efreet.service \
    /usr/share/dbus-1/services/org.enlightenment.Efreet.service

    sudo ln -sf /usr/local/share/xsessions/enlightenment.desktop \
    /usr/share/xsessions/enlightenment.desktop

    sudo updatedb
    beep_ok
    $TITLE "Update Complete."
    echo; cowsay -f www "That's All Folks!"; echo

#~ UNINSTALL E19
elif [ $INPUT == 3 ]; then
    clear; printf "\n$bld%s $off%s\n\n" "
Proceeding to uninstall Enlightenment 19..."
    sleep 1

    for I in $EPROG; do
        $TITLE "Processing ${I^} . . ."
        cd $E19/$I && remove
    done

    deep_clean

    sudo updatedb
    beep_ok
    echo; cowsay -d "That's All Folks!"; echo

#~ COMPLETE UNINSTALL
elif [ $INPUT == 4 ]; then
    clear; printf "\n$bld%s $off%s\n\n" "
Complete uninstallation of E19 and deps..."
    sleep 1

    if [ -x /usr/bin/grive ]; then
    sleep 1
    printf "$bdr%s $off%s\n" " GRIVE IS INSTALLED ON YOUR SYSTEM."
    printf "$bdr%s $off%s\n" " GOOGLE DRIVE WILL NOT FUNCTION PROPERLY IF"
    printf "$bdr%s $off%s\n" " YOU REMOVE ALL THE E19 DEVELOPMENT DEPS."
    printf "$bdr%s $off%s\n\n" " SORRY FOR THE INCONVENIENCE."
    #~ (Relaunch the script and select option #3)
    beep_exit
    exit 1
    fi

    for I in $EPROG; do
        $TITLE "Processing ${I^} . . ."
        cd $E19/$I && remove
    done

    deep_clean

    $TITLE "Processing Ubuntu Packages . . ."
    printf "\n$bld%s $off%s\n\n" "Removing binary dependencies..."

    if [ $CODE == en ]; then
        sudo apt-get autoremove $TRIM_EN
        sleep 1
    else
        sudo apt-get autoremove $TRIM
        sleep 1
    fi

    sudo dpkg --set-selections < $DOCUDIR/installed.txt
    sudo apt-get dselect-upgrade
    sudo apt-get update
    sudo apt-get dist-upgrade

    cd $HOME; echo
    rm $DOCUDIR/installed.txt &>/dev/null

    sudo apt-get autoremove --purge
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | \
    cut -d ' ' -f 2) &>/dev/null

    echo; read -p "Remove hidden ccache folder (compiler cache)? [Y/n] " answer
    case $answer in
        [yY] ) rm -rf .ccache/
        ;;
        [nN] ) printf "%s\n\n" "Do not delete ccache folder... OK"
        ;;
        *    ) rm -rf .ccache/
        ;;
    esac

    sudo updatedb
    beep_ok
    printf "\n%s\n\n" "Uninstall Complete."

#~ DEBUG
elif [ $INPUT == 5 ]; then
    clear; printf "\n$bld%s $off%s\n\n" "
Proceeding to update Enlightenment 19..."
    sleep 1

    printf "\n$bld%s $off%s\n\n" "Checking required Ubuntu packages..."
    if [ $CODE == en ]; then
        sudo apt-get install --yes $DEPS_EN
        sleep 1
    else
        sudo apt-get install --yes $DEPS
        sleep 1
    fi

    $TITLE "Processing Enlightenment Programs . . ."
    echo

    rebuild_for_debug
    wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz
    printf "\n$bdy%s $off%s\n" "Launching Enlightenment into a Xephyr window..."
    printf "\n$bdy%s $off%s" "
Log out of Enlightenment and close the Xephyr window when you're done."
    printf "\n$bdy%s $off%s\n" "
Then enter q to end the debugging session (quit gdb)."
    sleep 6
    cd $HOME/Enlightenment19/enlightenment/ && ./xdebug.sh
    #~ (see ./xdebug.sh --help for options)
    printf "\n$bdy%s $off%s\n" "Please check /var/crash/ for core dumps"
    printf "\n$bdy%s $off%s\n\n" "and look for a file called \
.e-crashdump.txt in your home folder."

else
    echo; beep_exit; exit 1
fi
