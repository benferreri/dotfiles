#!/bin/bash

# Fixes the year tag on re-released albums such that it matches the
# original release year, adding a new tag edition_year to record
# the year of that edition's specific release.
# Requirements: beets, bash
# Example: The 2009 remastered version of The Beatles' Revolver will
#          have its $year changed from 2009 to 1966, and a new
#          tag called $edition_year will be set as 2009.

# Usage:
if [ $# -eq 0 ]; then
    echo "Usage: year-editor.sh <beets album query>"
    echo "Examples:  year-editor.sh beatles revolver"
    echo "           year-editor.sh added:-1d.."
    echo "           year-editor.sh original_year:..1990"
    exit 1
fi

# needed for loop to allow spaces within strings
IFS=$'\n'; set -f

if [ $1 = "-a" ]; then
    shift
    album_path=( $(beet ls "$@" -a -f '$path') )
    args="$(printf ', path:%q' "${album_path[@]}")"
    args=${args:2}
    echo $args
    # get three year variables, including edition_year in case already set
    current_album_info=$(bash -c 'beet ls -a '"$args"' -f \$year-\$edition_year-\$original_year')
    IFS='-'
    current_album_info=( $current_album_info )
    # year values on album level
    year_album=${current_album_info[0]}
    edition_year_album=${current_album_info[1]}
    original_year_album=${current_album_info[2]}
    IFS=$'\n'
    
    # set new values if necessary
    if [ $edition_year_album = '$edition_year' ]; then
        bash -c "beet modify -a -y $args edition_year=$year_album"
        bash -c "beet modify -y $args edition_year=$year_album"
        if [ $original_year_album -gt 0 ]; then
            bash -c "beet modify -a -y $args year=$original_year_album"
            bash -c "beet modify -y $args year=$original_year_album"
        fi
        echo
    else
        echo "no changes needed"
        echo
    fi
else
    # loop through songs matching query
    for song_path in $(beet ls $@ -f '$path'); do
        echo "$song_path"
        # get three year variables, including edition_year in case already set
        current_track_info=$(beet ls "$song_path" -f '$year-$edition_year-$original_year')
        IFS='-'
        current_track_info=( $current_track_info )
        # year values on track level
        year=${current_track_info[0]}
        edition_year=${current_track_info[1]}
        original_year=${current_track_info[2]}
        IFS=$'\n'
        
        # set new track-level values if necessary
        if [ $edition_year = '$edition_year' ]; then
            beet modify -y "$song_path" edition_year=$year
            if [ $original_year -gt 0 ]; then
                beet modify -y "$song_path" year=$original_year
            fi
            echo
        else
            echo "no track-level changes needed"
            echo
        fi
        
    done
    
    # loop through albums matching query
    for album_path in $(beet ls -a $@ -f '$path'); do
        echo "$album_path"
        # get three year variables, including edition_year in case already set
        current_album_info=$(beet ls -a "$album_path" -f '$year-$edition_year-$original_year')
        IFS='-'
        current_album_info=( $current_album_info )
        # year values on album level
        year_album=${current_album_info[0]}
        edition_year_album=${current_album_info[1]}
        original_year_album=${current_album_info[2]}
        IFS=$'\n'
        
        # set new album-level values if necessary
        if [ $edition_year_album = '$edition_year' ]; then
            beet modify -a -y "$album_path" edition_year=$year_album
            if [ $original_year_album -gt 0 ]; then
                beet modify -a -y "$album_path" year=$original_year_album
            fi
            echo
        else
            echo "no album-level changes needed"
            echo
        fi
    done
fi
# unset this so as not to affect later operations in this shell
unset IFS; set +f
