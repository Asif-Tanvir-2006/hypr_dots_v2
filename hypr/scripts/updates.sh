#!/bin/bash

# Update official packages using pacman and get the count of updates
official_updates=$(pacman -Qu | wc -l)

if [ "$official_updates" -eq 0 ]; then
    notify-send --urgency=critical "System is Up to Date"
else
    notify-send --urgency=critical "Package Updates Available" "Official Updates: $official_updates"
fi
