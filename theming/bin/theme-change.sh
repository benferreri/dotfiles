#!/bin/bash

# usage: theme-change <IMAGE> <POWERLINE-COLOR>
#
# dependencies:
#       polybar
#       pywal
#       powerline
#       compton
#       rofi
#
# comment out appropriate sections of the script to remove
# unwanted dependencies

WALLPAPERDIR=$HOME/pictures/wallpapers/
DIMENSIONS=3840x2160

if [ $# -ge 1 ]; then
    IMG=$1
    IMGNAME=$(echo $IMG | sed 's/\([a-z,A-Z,0-9]*\)\..*/\1/')
    if [ $# -eq 2 ]; then
        PWRCOLOR=$2
    elif [ -f ${WALLPAPERDIR}${IMGNAME}.conf ]; then
        { read -r PWRCOLOR; read -r BGCOLOR; read -r WALARGS; } < ${WALLPAPERDIR}${IMGNAME}.conf       # reads lines of file into variables
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
if [ -z ${BGCOLOR+x} ]; then
    wal -i ${WALLPAPERDIR}${IMG} -b 444444
else
    wal $WALARGS -i ${WALLPAPERDIR}${IMG} -b $BGCOLOR
fi
# set the animated wallpaper if a gif was chosen
if [ ${IMG##*.} = "gif" ]; then
    # stop previous asetroot in case it's running
    killall asetroot
    # if gif dir does not exist, we need to split the gif for asetroot
    # this only occurs the first time this gif is being used
    if [ ! -d "${WALLPAPERDIR}${IMGNAME}" ]; then
        mkdir "${WALLPAPERDIR}${IMGNAME}"
        convert "${WALLPAPERDIR}${IMG}" -coalesce -resize ${DIMENSIONS}^ -gravity Center -extent ${DIMENSIONS} "${WALLPAPERDIR}${IMGNAME}"/%05d.gif && \
            asetroot ${WALLPAPERDIR}${IMGNAME}/ & disown
    else
        asetroot ${WALLPAPERDIR}${IMGNAME}/ & disown
    fi
fi

# change powerline color
sed -i "43 s/\(\"bg\":\) \(\"[^,]*\"\),/\1 \"$PWRCOLOR\",/" $HOME/.config/powerline/colorschemes/default.json

# change compton shadow color
. $HOME/.config/picom/colorswitch.sh
pkill picom
picom -b

# change rofi selection color
. $HOME/.cache/wal/colors.sh
sed -i "s/\(emphasis:.*\)\(#[a-zA-Z0-9]\{6\};\)/\1"$color3";/" $HOME/.config/rofi/onedark.rasi

# reset dunst; it breaks for some reason after change
pkill dunst
