#! /bin/env sh

RAMDISK_PATH="/ramdisk"

mkdir ${RAMDISK_PATH}
chmod 777 ${RAMDISK_PATH}

echo "tmpfs ${RAMDISK_PATH} tmpfs rw,nodev,nosuid,size=20M 0 0" >> /etc/fstab
