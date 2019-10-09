#!/bin/bash

if [ -z $@ ]; then
    echo current; ls --ignore=*.conf $HOME/pictures/wallpapers
else
    THEMES=$@
    if [ x"current" = x"${THEMES}" ]; then
        exit 0
    elif [ -n "${THEMES}" ]; then
        theme-change.sh ${THEMES} > /dev/null
    fi
fi
