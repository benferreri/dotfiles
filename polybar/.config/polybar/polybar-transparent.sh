#!/bin/bash
polybar="$HOME"/.config/polybar
if [ -f "$polybar"/config-stuck:m ]; then
    mv "$polybar"/config-stuck:m "$polybar"/config-stuck
    cp "$polybar"/config-float "$polybar"/config
    mv "$polybar"/config-float "$polybar"/config-float:m
else
    mv "$polybar"/config-float:m "$polybar"/config-float
    cp "$polybar"/config-stuck "$polybar"/config
    mv "$polybar"/config-stuck "$polybar"/config-stuck:m
fi
killall polybar
polybar mypolybar &
disown
