#!/bin/bash

source_folder="$HOME"
dest_folder="$HOME/Pictures/Screenshots"
screenshot_base_name="screenshot"
screenshot_ext=".png"

# Create the destination folder if it doesn't exist
mkdir -p "$dest_folder"

# Find the highest existing screenshot number
highest_number=0
for file in "$dest_folder"/"$screenshot_base_name"_*"$screenshot_ext"; do
    filename=$(basename "$file")
    number="${filename#"$screenshot_base_name"_}"
    number="${number%"$screenshot_ext"}"
    if [[ $number =~ ^[0-9]+$ && $number -gt $highest_number ]]; then
        highest_number=$number
    fi
done

# Increment the highest number to get the next screenshot number
next_number=$((highest_number + 1))

# Build the destination filename
dest_filename="$screenshot_base_name"_"$next_number$screenshot_ext"
dest_path="$dest_folder/$dest_filename"

# Move the screenshot from the source folder to the destination folder
mv "$source_folder/screenshot.png" "$dest_path"

echo "Moved $source_folder/screenshot.png to $dest_path"

