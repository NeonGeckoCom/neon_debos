#! /usr/bin/env bash

echo "### Added by the Mycroft image setup" >> /etc/pulse/default.pa
echo "set-default-sink alsa_output.usb-SEEED_ReSpeaker_4_Mic_Array__UAC1.0_-00.analog-stereo" >> /etc/pulse/default.pa
