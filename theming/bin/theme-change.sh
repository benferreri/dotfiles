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

wallpaperdir=$HOME/pictures/wallpapers/
dimensions=3840x2160

if [ $# -ge 1 ]; then
    img=$1
    imgname=$(echo $img | sed 's/\([a-z,A-Z,0-9]*\)\..*/\1/')
    if [ $# -eq 2 ]; then
        pwrcolor=$2
    elif [ -f ${wallpaperdir}${imgname}.conf ]; then
        { read -r pwrcolor; read -r bgcolor; read -r WALARGS; read -r gifspeed; } < ${wallpaperdir}${imgname}.conf       # reads lines of file into variables
        if [ -z ${gifspeed} ]; then
            gifspeed=100
        fi
    else
        pwrcolor=yellow # default
        gifspeed=100
    fi
else
    # defaults
    img=space.jpg
    imgname=space
    pwrcolor=mediumpurple
    gifspeed=100
fi

# change which pywal colors polybar uses (to colors-<imagename> file)
if [ -e $HOME/.config/polybar/colors-$imgname ]; then
    sed -i "s/\(colors-\).*/\1$imgname/" $HOME/.config/polybar/config
else
    sed -i "s/\(colors-\).*/\1space/" $HOME/.config/polybar/config
fi

# pywal
if [ -z ${bgcolor+x} ]; then
    wal -i ${wallpaperdir}${img} -b 191919
else
    wal $WALARGS -i ${wallpaperdir}${img} -b $bgcolor
fi
# set the animated wallpaper if a gif was chosen
if [ ${img##*.} = "gif" ]; then
    # stop previous asetroot in case it's running
    killall asetroot
    # if gif dir does not exist, we need to split the gif for asetroot
    # this only occurs the first time this gif is being used
    if [ ! -d "${wallpaperdir}${imgname}" ]; then
        mkdir "${wallpaperdir}${imgname}"
        convert "${wallpaperdir}${img}" -coalesce -resize ${dimensions}^ -gravity Center -extent ${dimensions} "${wallpaperdir}${imgname}"/%05d.gif && \
            asetroot ${wallpaperdir}${imgname}/ -t ${gifspeed} & disown
    else
        asetroot ${wallpaperdir}${imgname}/ -t ${gifspeed} & disown
    fi
fi

# change vimrc based on light or dark
if [ $WALARGS = "-l" ]; then
    cp $HOME/.vimrc-light $HOME/.vimrc
else
    cp $HOME/.vimrc-dark $HOME/.vimrc
fi

# change powerline color
sed -i "43 s/\(\"bg\":\) \(\"[^,]*\"\),/\1 \"$pwrcolor\",/" $HOME/.config/powerline/colorschemes/default.json

# change compton shadow color
. $HOME/.config/picom/colorswitch.sh
pkill picom
picom -b

# change rofi selection color
. $HOME/.cache/wal/colors.sh
sed -i "s/\(emphasis:.*\)\(#[a-zA-Z0-9]\{6\};\)/\1"$color3";/" $HOME/.config/rofi/onedark.rasi

# reset dunst; it breaks for some reason after change
pkill dunst
