#!/bin/bash
show=$(zenity --scale --text="Select a number" --value="1000" --min-value="1000" --max-value="25000" –step="5")
#killall gammastep &&
sleep 3
# Check if gammastep is running
if pgrep -x "gammastep" > /dev/null
then
    # gammastep is running, so let's kill it
    pkill gammastep
else
    # gammastep is not running, so let's start it
    #echo "gammastep is not running. Starting it..."
    
    gammastep  -l 0:0 -t "${show}":"${show}" &
fi

