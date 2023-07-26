#!/bin/bash

SWAP_FILE="/swapfile"

rm /opt/neon/make_swap || echo "/opt/neon/make_swap"

# Check for existing swapfile
if [ -f ${SWAP_FILE} ]; then
    echo "${SWAP_FILE} already exists"
    exit 0
fi

# Check memory info to optionally create/enable swapfile
mem_arr=($(grep ^MemTotal /proc/meminfo))
mem=${mem_arr[1]}
min_mem=2097153  # 2GiB + 1B


if [ "${mem}" -le "${min_mem}" ]; then
    echo "Creating swapfile"
    fallocate -l 1G ${SWAP_FILE}
    chmod 600 ${SWAP_FILE}
    mkswap ${SWAP_FILE}
    echo "${SWAP_FILE} none swap sw 0 0" >> /etc/fstab
    swapon "${SWAP_FILE}"
else
    echo "${mem} > ${min_mem}"
fi