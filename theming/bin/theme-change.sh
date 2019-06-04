#!/bin/bash

WALLPAPERDIR=$HOME/pictures/wallpapers/

# usage: theme-change <IMAGE> <POWERLINE-COLOR>
if [ $# -ge 1 ]; then
    IMG=$1
    IMGNAME=$(echo $IMG | sed 's/\([a-z,A-Z,0-9]*\)\..*/\1/')
    if [ $# -eq 2 ]; then
        PWRCOLOR=$2
    else
        PWRCOLOR=yellow # default
    fi
else
    # defaults
    IMG=space.jpg
    IMGNAME=space
    PWRCOLOR=mediumpurple
fi

# change which pywal colors polybar uses (to colors-<imagename> file)
if [ -e $HOME/.config/polybar/colors-$IMGNAME ]; then
    sed -i "s/\(colors-\).*/\1$IMGNAME/" $HOME/.config/polybar/config
else
    sed -i "s/\(colors-\).*/\1space/" $HOME/.config/polybar/config
fi

# pywal
wal -i ${WALLPAPERDIR}${IMG} -b 444444

# change powerline color
sed -i "43 s/\(\"bg\":\) \(\"[^,]*\"\),/\1 \"$PWRCOLOR\",/" $HOME/.config/powerline/default.json

# change compton shadow color
. $HOME/.config/compton/colorswitch.sh
pkill compton
compton &

# change rofi selection color
. $HOME/.cache/wal/colors.sh
sed -i "s/\(emphasis:.*\)\(#[a-zA-Z0-9]\{6\};\)/\1"$color3";/" $HOME/.config/rofi/onedark.rasi

# reset dunst; it breaks for some reason after change
pkill dunst
