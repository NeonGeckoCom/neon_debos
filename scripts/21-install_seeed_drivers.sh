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

cd /tmp

# Install like raspovos
git clone https://github.com/HinTak/seeed-voicecard -b v5.15
# seeed-voicecard
kernels=($(ls /lib/modules))
ver="0.3"
mod="seeed-voicecard"
marker="0.0.0"

cp seeed-voicecard/*.dtbo /boot/firmware/overlays
cp seeed-voicecard/*.dts /boot/firmware/
mkdir -p /usr/src/$mod-$ver
cp -a seeed-voicecard/* /usr/src/$mod-$ver/
cd seeed-voicecard
dkms add -m $mod -v $ver

echo "Looking for kernel with build dir in ${kernels[*]}"
for current_kernel in "${kernels[@]}"; do
  if [[ "${current_kernel}" == 6.* ]]; then
    echo "Skipping Kernel 6.x build"
  else
    dkms build -k "${current_kernel}" -m $mod -v $ver && {
            dkms install --force -k "${current_kernel}" -m $mod -v $ver
            }
  fi
done
