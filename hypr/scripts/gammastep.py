import os
import subprocess

# Define the file name with tilde (~)
file_name = "~/.config/hypr/scripts/exists.txt"

# Expand the tilde to the actual home directory path
file_name = os.path.expanduser(file_name)

# Check if the file exists
if os.path.exists(file_name):
    # Execute gammastep command in the background
    subprocess.Popen(["gammastep", "-l", "0:0", "-t", "3500:3500"])
    os.system("notify-send 'Info' 'Night light is being activated..'")
    # Delete the file
    os.remove(file_name)
else:
    # Kill gammastep process
    subprocess.run(["pkill", "gammastep"])
    os.system("notify-send 'Info' 'Night Light Off'")
    
    # Create the file
    open(file_name, 'a').close()
