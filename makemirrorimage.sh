#!/bin/sh
# TYPE: Bash Shell script.
# PURPOSE: This bash shell script allows you to easily mirror an image. 
# People will like photo's of themselves more if the image is mirrored.
# REQUIRES: imagemagick, Ubuntu 12.04 LTS or newer
# Copyright (c) 2009  Thomas Bruederli (thomasb), Project leader and head developer of the Roundcube webmail project.
# REVISED: 20130404
# Updated by: markrijckenberg@gmail.com

infile=$1
outfile=$2
width=120
height=32
alpha=30

convert -size ${width}x${height} xc:none \
\( \( -flip $infile -crop ${width}x${height}+0+0 \) \
  -size ${width}x${height} gradient: -evaluate Pow 1.4 \
  -compose Copy_Opacity -composite \) \
-compose blend -set "option:compose:args" $alpha -composite $outfile
