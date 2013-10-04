#!/usr/bin/env bash

 # ********************************  
 # *** FUNCTIONS  
 # ********************************  

  function make_js {
    js=$(mktemp)
    cat > $js <<_EOF
      var wallpaper = "$PICTURE_DIR/$filename";
      var activity = activities()[0];
      activity.currentConfigGroup = new Array("Wallpaper", "image");
      activity.writeConfig("wallpaper", wallpaper);
      activity.writeConfig("userswallpaper", wallpaper);
      activity.reloadConfig();
_EOF
}
 function kde_wallpaper {
   make_js
   qdbus org.kde.plasma-desktop /MainApplication loadScriptInInteractiveConsole $js > /dev/null
   # sleep 2
   xdotool search --name "Desktop Shell Scripting Console -- 
Plasma Desktop Shell" windowactivate key ctrl+e key ctrl+w
   rm -f "$js"
   dbus-send --dest=org.kde.plasma-desktop /MainApplication org.kde.plasma-desktop.reparseConfiguration
   dbus-send --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ReloadConfig
   dbus-send --dest=org.kde.kwin /KWin org.kde.KWin.reloadConfig
   # kbuildsycoca4 2>/dev/null && kquitapp plasma-desktop 2>/dev/null ; kstart plasma-desktop > /dev/null 2>&1
 }
 function xfce_wallpaper {
   xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $PICTURE_DIR/$filename
 }
 function lxde_wallpaper {
   pcmanfm -w "$PICTURE_DIR/$filename"
 }
 function mate_wallpaper {
   gsettings set org.mate.background picture-filename $PICTURE_DIR/$filename
 }
 function e17_wallpaper {
   OUTPUT_DIR=~/.e/e/backgrounds
   FileName=$PICTURE_DIR/$filename
   edcFile=~/tmp/Bing.edc

   echo 'images { image: "'$FileName'" LOSSY 90; }' > $edcFile
   echo 'collections {' >> $edcFile
   echo 'group { name: "e/desktop/background";' >> $edcFile
   echo 'data { item: "style" "4"; }' >> $edcFile
   echo 'data.item: "noanimation" "1";' >> $edcFile
   echo 'max: 990 742;' >> $edcFile
   echo 'parts {' >> $edcFile
   echo 'part { name: "bg"; mouse_events: 0;' >> $edcFile
   echo 'description { state: "default" 0.0;' >> $edcFile
   echo 'aspect: 1.334231806 1.334231806; aspect_preference: NONE;' >> $edcFile
   echo 'image { normal: "'$FileName'";  scale_hint: STATIC; }' >> $edcFile
   echo '} } } } }' >> $edcFile
   edje_cc -nothreads ~/tmp/Bing.edc -o $OUTPUT_DIR/Bing.edj
   sleep 2 && rm -f ~/tmp/Bing.edc
   echo 'Enlightenment e17 Bing.edj file created'
   enlightenment_remote -desktop-bg-del 0 0 -1 -1
   enlightenment_remote -desktop-bg-add 0 0 -1 -1 $OUTPUT_DIR/Bing.edj;
 }
 
  }
 function razor_wallpaper {
   gsettings set org.mate.background picture-filename $PICTURE_DIR/$filename
   pcmanfm -w "$PICTURE_DIR/$filename"
   sed -i -e "s/\(screens\\\\1\\\\desktops\\\\1\\\\wallpaper=\).*/\1${"$PICTURE_DIR/$filename"}/g" ./razor/desktop.conf
   xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $PICTURE_DIR/$filename
 }
 
 function usage {
   printf "%s\n%s\n\n%s\n%s\n\n%s\n\n%s" \
   "Bing will download the Bing Wallpaper Of The Day,"\
   "and (optionally) set that picture as the new wallpaper."\
   "Based on original script by thejandroman, and expanded by Paul Arnote for PCLinuxOS."\
   "Originally published in The PCLinuxOS Magazine (http://pclosmag.com), Oct. 2013 issue."\
   "URL: http://pclosmag.com/html/Issues/201310/page03.html"\
   "Works for KDE4, Xfce, LXDE, Mate and e17 desktops."\
   "Usage: $0 [arguments]"\

   printf "\n %s\t%s" \
   "-h, --help" "This help text"
   printf "\n %s\t\t%s" \
   "-d" "Download pictures ONLY"
   printf "\n %s\t\tSetup for the %s" \
   "--xfce"    "XFCE4 Desktop"\
   "--mate"    "Mate Desktop"\
   "--lxde"    "LXDE Desktop"\
   "--kde4"    "KDE4 Desktop"\
   "--e17"    "Enlightenment Desktop"
   printf "\n"
 }

 # ********************************  
 # *** MAIN  
 # ********************************  

 if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ "$1" == "" ]; then
   usage
   exit
 fi

 echo "===================="  
 echo "== Bing Wallpaper =="  
 echo "===================="  

PICTURE_DIR=~/Wallpaper/Bing/

mkdir -p $PICTURE_DIR

sleep 1

urls=( $(curl -s http://www.bing.com|grep -Eo "url:'.*?'"|sed -e "s/url:'\([^']*\)'.*/
http:\/\/bing.com\1/"|sed -e "s/\\\//g") )

for p in ${urls[@]}; do
filename=$(echo $p|sed -e "s/.*\/\(.*\)/\1/")
    if [ ! -f $PICTURE_DIR/$filename ]; then
echo "Downloading: $filename ..."
    curl -Lo "$PICTURE_DIR/$filename" $p
    else
echo "Skipping: $filename ..."
    fi
done

   if [ "$1" != "-d" ]; then
     echo "Setting image as wallpaper"
   fi

   # For Xfce
   if [ "$1" == "--xfce" ]; then
     xfce_wallpaper
   fi
   # For LXDE
   if [ "$1" == "--lxde" ]; then
     lxde_wallpaper
   fi
   # For Mate
   if [ "$1" == "--mate" ]; then
     mate_wallpaper
   fi
   # For KDE4
   if [ "$1" == "--kde4" ]; then
     kde_wallpaper
   fi
   # For e17
   if [ "$1" == "--e17" ]; then
     e17_wallpaper
   fi
   # For razor
   if [ "$1" == "--razor" ]; then
     razor_wallpaper
   fi
