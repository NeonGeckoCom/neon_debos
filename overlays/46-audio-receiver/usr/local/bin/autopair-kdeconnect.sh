#!/bin/bash

dbus-monitor --session "interface='org.freedesktop.Notifications',member='Notify'" |
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
