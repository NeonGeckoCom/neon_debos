#!/bin/bash

sudo apt install -y git bc bison flex libssl-dev make libc6-dev libncurses5-dev\
    crossbuild-essential-arm64 libncurses5-dev binutils

git clone --depth=1 https://github.com/raspberrypi/linux -b rpi-5.15.y
cd linux || exit 10
export KERNEL=kernel8
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
mv .config .config.old
cp ../.config .config
make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- deb-pkg
cd .. || exit 10
rm -rf linux
for file in *.deb; do
  kernel_ver=${file%_*}
  kernel_ver=${kernel_ver##*_}
  kernel_ver=${kernel_ver%-*}
  kernel_dir="rpi4_${kernel_ver}_arm64"
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
  ar -m -c -a sdsd "${kernel_dir}/${file}" "${work_dir}/debian-binary" "${work_dir}/control.tar.xz" "${work_dir}/data.tar.xz"
  rm -r "${work_dir}"
done

zip -j "${kernel_dir}.zip" "${kernel_dir}/*"
rm -r "${kernel_dir}"
