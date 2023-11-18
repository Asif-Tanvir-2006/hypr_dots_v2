# !/bin/bash

# Get the latest screenshot number
latest_screenshot=$(ls -v ~/Pictures/Screenshots/screenshot_*.png | tail -n 1)
latest_screenshot_number=$(basename "$latest_screenshot" | sed 's/screenshot_\(.*\)\.png/\1/')
echo ${latest_screenshot_number}
# Set the path to the latest screenshot
latest_screenshot_path=~/Pictures/Screenshots/screenshot_${latest_screenshot_number}.png
latest_screenshot_named=screenshot_${latest_screenshot_number}
echo $latest_screenshot_path    
# Create the notification with the latest screenshot
notify-send -i ${latest_screenshot_path} -t 1500 "${latest_screenshot_named}" "Saved" --action=yes="Open folder" > ~/.config/rofi/screenshot/info

# Define the file to check
file_to_check="$HOME/.config/rofi/screenshot/info"

# Check if the file exists
if [ -e "$file_to_check" ]; then
    # Check if the file contains the word "yes"
    if grep -q "yes" "$file_to_check"; then
        # Execute Thunar
        thunar ~/Pictures/Screenshots
    else
        echo "The file '$file_to_check' does not contain 'yes'."
    fi
else
    echo "The file '$file_to_check' does not exist."
fi
