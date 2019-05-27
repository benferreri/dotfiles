#!/bin/bash

TOGGLE=$HOME/.config/toggle-theme

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    theme-change.sh space.jpg mediumpurple
else
    rm $TOGGLE
    theme-change.sh autumn.jpg darkred
fi
