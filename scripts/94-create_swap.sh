#! /bin/env sh

SWAP_FILE="/swapfile"
fallocate -l 2G ${SWAP_FILE}
chmod 600 ${SWAP_FILE}
mkswap ${SWAP_FILE}

echo "${SWAP_FILE} none swap sw 0 0" >> /etc/fstab
