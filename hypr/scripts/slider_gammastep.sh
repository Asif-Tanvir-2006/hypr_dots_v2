#!/bin/bash
#x=$(zenity --scale --text="Night Light Strength" --value="50" --min-value="4" --max-value="100" –step="5")
x=50
result=$(echo "scale=2; ($x / 100) * 25000" | bc)
echo $result
