#!/bin/bash

# Function to get disk usage percentage
get_disk_usage() {
    disk_device="/dev/sdb2"
    disk_usage=$(df -h "$disk_device" | tail -n 1)
    usage_percentage=$(echo "$disk_usage" | awk '{print int($5)}')
    echo "$usage_percentage%"
}
# Function to get CPU usage percentage
get_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
    echo "$cpu_usage%"
}

# Function to get RAM usage percentage
get_ram_usage() {
    ram_usage=$(free | awk '/Mem/{print int($3/$2 * 100)}')
    echo "$ram_usage%"
}

# Call functions to get usage percentages
disk_usage=$(get_disk_usage)
cpu_usage=$(get_cpu_usage)
ram_usage=$(get_ram_usage)

# Display the results
echo " $cpu_usage   $ram_usage   $disk_usage"
