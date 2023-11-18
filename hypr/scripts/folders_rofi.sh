#!/usr/bin/env bash

# Define the command to launch the Rofi menu
rofi_command="rofi -theme ~/.config/rofi/config.rasi"

# Define folder options
downloads="  Downloads"
documents="󰈙  Documents"
pictures="  Pictures"
screenshots="󰹑  Screenshots"
audio_files="󰎈  Audio files"
videos="  Videos"

# Combine the options into a single string
options="$documents\n$videos\n$screenshots\n$audio_files\n$downloads\n$pictures"

# Show the Rofi menu and get the user's choice
chosen="$(echo -e "$options" | $rofi_command -p "Folders" -dmenu -selected-row 0)"

# Perform actions based on the user's choice
case $chosen in
    $screenshots)
        thunar ~/Pictures/Screenshots
        ;;
    $audio_files)
        thunar ~/Audio
        ;;
    $videos)
        thunar ~/Videos
        ;;
    $pictures)
        thunar ~/Pictures
        ;;
    $documents)
        thunar ~/Documents
        ;;
    $downloads)
        thunar ~/Downloads
        ;;
esac

