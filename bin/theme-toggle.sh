#!/bin/bash

TOGGLE=$HOME/.config/toggle-theme

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    sed -i 's/\(colors-\).*/\1space/' /home/ben/.config/polybar/config
    wal -i /home/ben/pictures/space.jpg -b 444444
else
    rm $TOGGLE
    sed -i 's/\(colors-\).*/\1autumn/' /home/ben/.config/polybar/config
    wal -i /home/ben/pictures/autumn.jpg -b 444444
    
fi
