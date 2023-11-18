#!/bin/bash

# Directories to scan
scan_dirs=("Pictures" "Downloads" "Videos" "Documents" "Misc" "Audio")

# Create target directories if they don't exist
mkdir -p ~/Pictures ~/Documents ~/Videos ~/Misc ~/Audio ~/Misc/Compressed

# Add the home directory to the list of directories to scan
scan_dirs+=("$HOME")

# Iterate through the specified directories
for dir in "${scan_dirs[@]}"; do
    # Get the absolute path of the current directory
    full_dir="$dir"
    
    # Check if the directory exists
    if [ -d "$full_dir" ]; then
        # Iterate through files in the current directory
        for file in "$full_dir"/*; do
            if [ -f "$file" ]; then
                # Get the file extension
                extension="${file##*.}"
                
                # Check if the file extension is ".fdmdownload"
                if [ "$extension" != "fdmdownload" ]; then
                    # Move files based on their extension
                    case "$extension" in
                        png|jpg|jpeg|webp)
                            mv "$file" ~/Pictures/
                            ;;
                        doc|docx|pdf|txt)
                            mv "$file" ~/Documents/
                            ;;
                        mp4|avi|mkv)
                            mv "$file" ~/Videos/
                            ;;
                        wav|ogg|mp3|flac|m4a)
                            mv "$file" ~/Audio/
                            ;;
                        zip|tar|rar|gz|xz|7z)
                            mv "$file" ~/Misc/Compressed/
                            ;;
                        *)
                            mv "$file" ~/Misc/
                            ;;
                    esac
                fi
            fi
        done
    fi
done

notify-send "Info" "Sorting complete."
