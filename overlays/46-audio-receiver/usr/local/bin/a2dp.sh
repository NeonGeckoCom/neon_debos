#!/bin/bash
neon_uid=$(id -u neon)
export PULSE_RUNTIME_PATH="/run/user/$neon_uid/pulse/"
MAC="$1"
pactl set-card-profile bluez_card.$MAC a2dp_sink
pactl set-default-sink bluez_sink.$MAC.a2dp_sink
