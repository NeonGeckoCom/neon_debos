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

# Build Vocalfusion drivers for all installed kernels

# Set to exit on error
set -Ee

export PIPX_HOME=/opt/neon/pipx
export PIPX_BIN_DIR=/bin

[ -d ${PIPX_HOME} ] || mkdir -p ${PIPX_HOME}
pipx install sj201-interface==0.0.3a2

kernels=($(ls /lib/modules))
echo "Looking for kernels with build dir in ${kernels[*]}"
for k in "${kernels[@]}"; do
  if [ -d "/lib/modules/${k}/build" ]; then
    kernel="${k}"
    echo "Building for kernel ${kernel}"

    # Build and load VocalFusion Driver
    git clone https://github.com/OpenVoiceOS/vocalfusiondriver
    cd vocalfusiondriver/driver || exit 10
    sed -ie "s|\$(shell uname -r)|${kernel}|g" Makefile
    make -j${1:-} all || exit 2
    mkdir -p "/lib/modules/${kernel}/kernel/drivers/vocalfusion"
    cp vocalfusion* "/lib/modules/${kernel}/kernel/drivers/vocalfusion" || exit 2
    cp ../*.dtbo /boot/overlays/
    cd ../..
    rm -rf vocalfusiondriver

    depmod "${kernel}" -a
  fi
done
# `modinfo -k ${kernel} vocalfusion-soundcard` should show the module info now

# Ensure execute permissions
chmod -R ugo+x /usr/bin
chmod -R ugo+x /usr/libexec
chmod ugo+x /opt/neon/configure_sj201_on_boot.sh


# Enable system services
systemctl enable sj201.service
systemctl enable sj201-reset.service
systemctl enable sj201-shutdown.service

echo "SJ201 Setup Complete"
