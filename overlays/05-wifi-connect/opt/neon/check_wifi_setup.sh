#!/bin/bash

ip route | grep default

if [ $? != 0 ]; then
    if [ -n "$(ls /etc/NetworkManager/system-connections/)" ]; then
        echo "Network Configured, waiting for reconnection"
        sleep 15
    else
        echo "No Networks Configured"
    fi
    ip route | grep default
fi
if [ $? != 0 ]; then
    echo "Network not connected, starting wifi-connect"
    wifi-connect  --portal-ssid Neon
fi
