#! /usr/bin/env bash

ROOT_DEV=${ROOT_DEV:-"/dev/mmcblk0p2"}

# Set boot device
sed -i "s#@@root_dev@@#$ROOT_DEV#g" /boot/firmware/cmdline.txt
