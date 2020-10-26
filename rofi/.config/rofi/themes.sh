#!/bin/bash

if [ -z $@ ]; then
    echo current; find $HOME/pictures/wallpapers -maxdepth 1 -not -type d -not -iname '*.conf' -exec basename {} \;
else
    THEMES=$@
    if [ x"current" = x"${THEMES}" ]; then
        exit 0
    elif [ -n "${THEMES}" ]; then
        theme-change.sh ${THEMES} > /dev/null
    fi
fi
