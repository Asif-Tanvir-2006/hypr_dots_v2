#!/bin/bash

# Define the directory where your wallpapers are stored
wallpaper_dir="$HOME/.config/wallpapers"

# Get a list of all image files in the directory and extract their filenames
wallpapers=$(find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | sort | xargs -n 1 basename)

# Use Rofi to display the wallpaper options
chosen_wallpaper=$(echo "$wallpapers" | rofi -dmenu -p "Select Wallpaper")

# Set the chosen wallpaper using swaybg
if [ -n "$chosen_wallpaper" ]; then
    wallpaper_path="$wallpaper_dir/$chosen_wallpaper"
    swaybg -i "$wallpaper_path"
fi

