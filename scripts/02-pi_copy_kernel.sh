#!/bin/bash

# Set to exit on error
set -Ee

cd /boot

if [ $1 = "armhf" ]; then
    cp /boot/vmlinuz-* /boot/firmware/kernel.img
elif [ -f /boot/kernel8.img ]; then
    cp /boot/kernel8.img /boot/firmware/kernel8.img
else
    cp /boot/vmlinuz-* /boot/firmware/kernel8.img.gz
    gunzip /boot/firmware/kernel8.img.gz
fi
