#!/bin/bash
# NEON AI (TM) SOFTWARE, Software Development Kit & Application Framework
# All trademark and other rights reserved by their respective owners
# Copyright 2008-2022 Neongecko.com Inc.
# Contributors: Daniel McKnight, Guy Daniels, Elon Gasper, Richard Leeds,
# Regina Bloomstine, Casimiro Ferreira, Andrii Pernatii, Kirill Hrymailo
# BSD-3 License
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from this
#    software without specific prior written permission.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS;  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE,  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Set to exit on error
set -Ee

pip install wheel
pip install sj201-interface

# Determine kernel with build directory
# TODO: Better way to detect appropriate kernel
if [ -d /lib/modules/5.15.72-v8+ ]; then
    kernel=5.15.72-v8+
elif [ -d /lib/modules/5.15.61-v8+ ]; then
    kernel=5.15.61-v8+
elif [ -d /lib/modules/5.10.103-v8+ ]; then
    kernel=5.10.103-v8+
elif [ -d /lib/modules/5.4.51-v8-raspi2 ]; then
    kernel=5.4.51-v8-raspi2
elif [ "$(ls -1 /lib/modules | wc -l)" -gt 1 ]; then
    kernels=($(ls /lib/modules))
    echo "Looking for kernel with build dir in ${kernels[*]}"
    for k in "${kernels[@]}"; do
        if [ -d "/lib/modules/${k}/build" ]; then
            kernel="${k}"
            echo "Selected kernel ${kernel}"
            break
        fi
    done
    if [ -z ${kernel} ]; then
        echo "No build files available. Picking kernel=${kernels[0]}"
        kernel=${kernels[0]}
    fi
else
    kernel=$(ls /lib/modules)
    echo "Only one kernel available: ${kernel}"
fi
#kernel="5.4.0-1052-raspi"

# Build and load VocalFusion Driver
git clone https://github.com/OpenVoiceOS/vocalfusiondriver
cd vocalfusiondriver/driver || exit 10
sed -ie "s|\$(shell uname -r)|${kernel}|g" Makefile
make all || exit 2
mkdir -p "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
cp vocalfusion* "/lib/modules/${kernel}/kernel/drivers/vocalfusion" || exit 2
cd ../..
rm -rf vocalfusiondriver

depmod ${kernel} -a
# `modinfo -k ${kernel} vocalfusion-soundcard` should show the module info now

# Configure user permissions
#usermod -aG bluetooth pulse
usermod -aG pulse root
usermod -aG pulse-access root

# Disable userspace pulseaudio services
systemctl --global disable pulseaudio.service pulseaudio.socket

# Ensure execute permissions
chmod -R ugo+x /usr/bin
chmod -R ugo+x /usr/sbin
chmod ugo+x /opt/neon/configure_sj201_on_boot.sh


# Enable system services
systemctl enable pulseaudio.service
systemctl enable sj201.service
systemctl enable sj201-shutdown.service

echo "SJ201 Setup Complete"
