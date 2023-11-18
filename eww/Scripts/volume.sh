#!/bin/bash

# Run the amixer command to get the current volume information
output=$(amixer get Master)

# Use awk to extract the volume percentage
volume=$(echo "$output" | awk -F"[][]" '/\[/{print $2}')

if [ -n "$volume" ]; then
    echo "󰕾 $volume"
else
    echo "Volume information not found"
fi
