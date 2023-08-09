#!/bin/bash

TIMEOUT=${1:-60}  # Set default value of 60 if $1 is not provided

{
    echo "power on"
    sleep 1
    echo "agent off"
    sleep 1
    echo "agent NoInputNoOutput"
    sleep 1
    echo "default-agent"
    sleep 1
    echo "pairable on"
    sleep 1
    echo "discoverable on"
    sleep 1
    echo "scan on"
    sleep "$TIMEOUT"  # Allow some time for devices to pair
    echo "pairable off"
    sleep 1
    echo "discoverable off"
    sleep 1
    echo "scan off"
    sleep 1
    echo "exit"
} | bluetoothctl