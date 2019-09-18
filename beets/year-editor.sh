#!/bin/bash

# Fixes the year tag on re-released albums such that it matches the
# original release year, adding a new tag edition_year to record
# the year of that edition's specific release.
# Requirements: beets, bash
# Example: The 2009 remastered version of The Beatles' Revolver will
#          have its $year changed from 2009 to 1966, and a new
#          tag called $edition_year will be set as 2009.

# Usage:
if [ $# = 0 ]; then
    echo "Usage: year-editor.sh <beets album query>"
    echo "Examples:  year-editor.sh beatles revolver"
    echo "           year-editor.sh added:-1d.."
    echo "           year-editor.sh original_year:..1990"
    exit 1
fi

# needed for loop to allow spaces within strings
IFS=$'\n'; set -f
# loop through songs matching query
for song in $(beet ls $@ -f '$path'); do
    echo "$song"
    # get three year variables, including edition_year in case already set
    YEARS=$(beet ls "$song" -f '$year-$edition_year-$original_year')
    IFS='-'
    array=( $YEARS )
    YEAR=${array[0]}
    EDITION_YEAR=${array[1]}
    ORIGINAL_YEAR=${array[2]}
    IFS=$'\n'
    # set new values if necessary
    if [ $EDITION_YEAR = '$edition_year' ]; then
        beet modify -y "$song" edition_year=$YEAR
        if [ $ORIGINAL_YEAR -gt 0 ]; then
            beet modify -y "$song" year=$ORIGINAL_YEAR
        fi
        echo
    else
        echo "no changes needed"
        echo
    fi
done
# unset this so as not to affect later operations in this shell
unset IFS; set +f
