#!/bin/bash

# Set to exit on error
set -Ee

kernel_version="1.20220308~buster-1"

wget http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel_${kernel_version}_arm64.deb
wget http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel-headers_${kernel_version}_arm64.deb
wget http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/linux-libc-dev_${kernel_version}_arm64.deb

dpkg -i ./*.deb
rm ./*.deb
echo "Kernel installation complete"