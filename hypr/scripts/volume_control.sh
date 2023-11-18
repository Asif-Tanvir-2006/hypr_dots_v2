#!/bin/bash

# Function to get the current volume level
get_volume() {
    pactl list sinks | awk '/Volume: front-left/{ print $5 }'
}

# Function to show a notification with volume progress
show_volume_notification() {
    local volume_icon="notification-audio-volume"
    local volume_level=$(get_volume)
    local progress_bar=$(echo -e "$volume_level" | cut -d'%' -f1 | awk '{ printf "%s", $1/2; }')

   notify-send "󰕾 Volume: $volume_level"\
    -h string:x-canonical-private-synchronous:volume_control \
    -h int:value:$progress_bar
}

# Main script
case $1 in
    increase)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        show_volume_notification
        ;;
    decrease)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        show_volume_notification
        ;;
    *)
        echo "Usage: $0 [increase | decrease]"
        ;;
esac