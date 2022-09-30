#!/bin/bash

# Set to exit on error
set -Ee

git clone https://github.com/raspberrypi/userland
cd userland || exit 10
./buildme --aarch64
cd ..
rm -r userland
ln -s /opt/vc/bin/* /usr/bin/
ln -s /opt/vc/lib/* /usr/lib/
ln -s /boot/firmware/overlays /boot/overlays