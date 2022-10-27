#!/bin/bash

# Set to exit on error
set -Ee

git clone https://github.com/raspberrypi/userland
cd userland || exit 10
./buildme --aarch64
cd ..
rm -r userland
ln -s /opt/vc/bin/* /usr/bin/
for file in /opt/vc/lib/*; do
    ln -s "${file}" /usr/lib/ && echo "Linked ${file}" || echo "File exists, ignoring ${file}"
done
rm -rf /boot/overlays
ln -s /boot/firmware/overlays /boot/overlays
