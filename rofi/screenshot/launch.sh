
dir="$HOME/.config/rofi/screenshot"
theme='style'
scriptsDir="$HOME/.config/hypr/scripts"
# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Screen Capture" \
		-mesg "Select an option:" \
		-theme ${dir}/${theme}.rasi <<EOF
󰹑


󰔛
EOF
}

# Execute Command
run_cmd() {
	case "$1" in
		'󰹑')
			sleep 0.5 && grimblast --freeze save screen ~/screenshot.png && ${scriptsDir}/ss_sorter.sh && ${dir}/notify.sh
			;;
		'')
			grimblast --notify copy area
			;;
		'')
			grimblast save area screenshot.png && ${scriptsDir}/ss_sorter.sh && ${dir}/notify.sh 
			;;
		'󰔛')
			input_float=$(zenity --entry --title "Delay in seconds" --text "Delay in seconds: ")

			# Check if the user canceled the input or left it empty
			if [ -z "$input_float" ]; then
				zenity --error --title "Error" --text "Input is empty or canceled."
				exit 1
			fi

			# Check if the input is a valid float
			if ! [[ "$input_float" =~ ^[+-]?[0-9]*\.?[0-9]+$ ]]; then
				zenity --error --title "Error" --text "Invalid input. Please enter a valid float."
				exit 1
			fi

			# Sleep for the specified number of seconds
			sleep "$input_float"

			# Capture
			grimblast --freeze save screen ~/screenshot.png && "${scriptsDir}/ss_sorter.sh"
			${dir}/notify.sh
			
			exit 0

			;;
	
		*)
			exit 0
			;;
	esac
}

# Actions
chosen="$(rofi_cmd)"
run_cmd "$chosen"
