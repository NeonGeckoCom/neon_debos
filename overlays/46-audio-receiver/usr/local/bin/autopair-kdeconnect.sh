#!/bin/bash

# Set default timeout to 30 seconds
timeout_duration=30

# If an argument is provided, use it as the timeout
if [ "$#" -eq 1 ]; then
    timeout_duration="$1"
    elif [ "$#" -gt 1 ]; then
    echo "Usage: $0 [timeout_in_seconds]"
    exit 1
fi

# Create a cleanup function
cleanup() {
    pkill -P $$ # Kill all subprocesses started by this script
}

trap cleanup EXIT

# Use timeout to run dbus-monitor for the specified duration
timeout "$timeout_duration" dbus-monitor --session "interface='org.freedesktop.Notifications',member='Notify'" |
while read -r line; do
    if [[ $line == *"Pairing request from"* ]]; then
        # Extract the full device name
        device_name=$(echo "$line" | grep -oP 'Pairing request from \K(.*?)(?= Key:)')
        
        echo "Extracted Device Name: $device_name"
        
        # Extract the device ID using the device name
        device_id=$(kdeconnect-cli -l | grep -E "$device_name:" | awk -F': ' '{print $2}' | awk '{print $1}')
        
        # Pair with the device using the device ID
        if [ ! -z "$device_id" ]; then
            kdeconnect-cli -d "$device_id" --pair
        else
            echo "Couldn't find device ID for $device_name"
        fi
    fi
done
