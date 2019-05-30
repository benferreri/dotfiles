#!/bin/bash

# makes shell variables color0 - color15
. "$HOME/.cache/wal/colors.sh"

# gets the second color of color6's triad by rotating R, G, and B right twice
shadowhex=$(echo $color6 | sed 's/#\([A-F0-9]\{2\}\)\([A-F0-9]\{2\}\)\([A-f0-9]\{2\}\)/\2\3\1/')

# get red, green, blue in the form of decimals out of 1.0
shadowred=$(echo "ibase=16; scale=2; x=${shadowhex:0:2}/FF; if(x<1) print 0; x" | bc)
shadowgreen=$(echo "ibase=16; scale=2; x=${shadowhex:2:2}/FF; if(x<1) print 0; x" | bc)
shadowblue=$(echo "ibase=16; scale=2; x=${shadowhex:4:2}/FF; if(x<1) print 0; x" | bc)

# replace values in compton.conf with new values, normalized to 1.0 scale
sed -i "s/\(shadow-red = \)[01]\.[0-9]\{2\}/\1"${shadowred}"/" $HOME/.config/compton/compton.conf
sed -i "s/\(shadow-green = \)[01]\.[0-9]\{2\}/\1"${shadowgreen}"/" $HOME/.config/compton/compton.conf
sed -i "s/\(shadow-blue = \)[01]\.[0-9]\{2\}/\1"${shadowblue}"/" $HOME/.config/compton/compton.conf
