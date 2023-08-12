#!/bin/bash
source /etc/neon/neon_env.conf

# Check for provided timeout argument, default to 60 seconds if not provided
TIMEOUT=${1:-60}

# Enable Bluetooth
dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1 string:Powered variant:boolean:true

# Set Discoverable
dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1 string:Discoverable variant:boolean:true

# Start the Custom Agent
/home/neon/venv/python /usr/local/bin/auto-bt-agent.py &

# Allow devices to pair for a specified duration
sleep "$TIMEOUT"

# Stop Discoverability
dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci0 org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1 string:Discoverable variant:boolean:false

# Kill the custom agent
pkill -f auto-agent.py