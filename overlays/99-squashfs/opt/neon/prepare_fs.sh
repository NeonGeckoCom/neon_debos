#!/bin/bash

set -Ee

root_dev="sda"

total_size=$(lsblk -b | grep "^${root_dev}" | awk '{print $4}' | cut -dG -f1)
total_MiB=$(($((total_size / 1048576)) - 1))
start_MiB=$((total_MiB - 1024))
echo "total_size=${total_size} total_MiB=${total_MiB} start_MiB=${start_MiB}"
parted -a optimal /dev/sda mkpart primary linux-swap "${start_MiB}MiB" "${total_MiB}MiB"
mkswap /dev/${root_dev}4

#echo "yes" | parted -a optimal /dev/sda ---pretend-input-tty resizepart 3 "${start_MiB}MiB"
growpart /dev/${root_dev} 3
resize2fs /dev/sda3