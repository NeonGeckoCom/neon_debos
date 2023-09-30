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

sudo apt install -y git bc bison flex libssl-dev make libc6-dev libncurses5-dev\
    crossbuild-essential-arm64 libncurses5-dev binutils python3-dev build-essential

ROOT_PATH="$(pwd)"

# OPi kernel build requires this patch
wget https://github.com/armbian/build/raw/master/patch/misc/headers-debian-byteshift.patch -O /tmp/headers-debian-byteshift.patch

branch="orange-pi-5.10-rk3588"
# Get kernel source with rk3588 support
git clone --depth=1 https://github.com/orangepi-xunlong/linux-orangepi -b "${branch}" linux
cd linux || exit 10
#export KERNEL=kernel8
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- rk3588_linux.config

cp "../config-${branch}" .config

make -j8 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- deb-pkg
cd .. || exit 10
rm -rf linux
for file in *.deb; do
  kernel_ver=${file%_*}
  kernel_ver=${kernel_ver##*_}
  kernel_ver=${kernel_ver%-*}
  kernel_dir="opi5_${kernel_ver}_arm64"
  mkdir "${kernel_dir}"
  work_dir="${file%.*}"
  mkdir "${work_dir}"
  ar x --output "${work_dir}" "${file}"
#  mv "${file}" "${file}.old"
  unzstd "${work_dir}/control.tar.zst" -o "${work_dir}/control.tar"
  unzstd "${work_dir}/data.tar.zst" -o "${work_dir}/data.tar"
  rm "${work_dir}"/*.zst
  xz --compress "${work_dir}/control.tar"
  xz --compress "${work_dir}/data.tar"
  ar -m -c -a sdsd "${kernel_dir}/${file}" "${work_dir}/debian-binary" "${work_dir}/control.tar.xz" "${work_dir}/data.tar.xz" && echo "Wrote patched ${kernel_dir}/${file}"
  rm -r "${work_dir}"
done

cp "${kernel_dir}/"*.deb "${ROOT_PATH}/../../overlays/02-opi5/var/tmp/" && echo "Copied deb installers to overlay"
echo "Compressing ${kernel_dir}"
zip -j -r "${kernel_dir}.zip" "${kernel_dir}" || exit 2
rm -r "${kernel_dir}"
rm -r linux-*