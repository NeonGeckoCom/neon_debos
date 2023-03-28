#!/bin/bash

root_dev="sda"

total_size=$(lsblk -b | grep "^${root_dev}" | awk '{print $4}' | cut -dG -f1)
total_kB=$((total_size / 1024))
start_kB=$((total_kB - 1048576))
parted -a minimal /dev/sda mkpart primary linux-swap "${start_kB}kB" "${total_kB}kB"
mkswap /dev/${root_dev}4

growpart /dev/${root_dev} 3
resize2fs /dev/sda3