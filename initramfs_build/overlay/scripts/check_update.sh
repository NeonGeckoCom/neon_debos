#!/bin/sh
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

ROOT_PATH=${1}
UPDATE_FILE=${2}
ROOT_FILE=${3}
BACKUP_FILE=${4:-""}

# Validate update and optionally create backup
if [ ! -f "${UPDATE_FILE}" ]; then
  echo "No update (${UPDATE_FILE})"
  exit 0
elif [ -n "${BACKUP_FILE}" ]; then
  mv "${ROOT_FILE}" "${BACKUP_FILE}" && echo "Backed up existing image"
fi

# Apply update
mv "${UPDATE_FILE}" "${ROOT_FILE}" && echo "Applied updated rootfs"

# Clean up overlayFS changes
[ -d /backup/etc/NetworkManager ] || mkdir -p /backup/etc/NetworkManager
[ -d /backup/home ] || mkdir -p /backup/home
echo "Backing up overlay files"
mv "${ROOT_PATH}/etc/NetworkManager/system-connections" /backup/etc/NetworkManager/
mv "${ROOT_PATH}/etc/ssh/"ssh_host_*_key* /backup/etc/ssh
mv "${ROOT_PATH}/etc/shadow" /backup/etc/shadow
mv "${ROOT_PATH}/etc/machine-id" /backup/etc/machine-id
mv "${ROOT_PATH}/home/neon" /backup/home/ && rm -rf /backup/home/neon/venv
mv "${ROOT_PATH}/var" /backup/
mv "${ROOT_PATH}/root" /backup/
echo "Backed up relevant overlay"

rm -rf "${ROOT_PATH:?}/"* && echo "Removed old overlay"
mv /backup/* "${ROOT_PATH}/" && echo "Restored valid overlay"
mkdir -p "${ROOT_PATH}/opt/neon"
touch "${ROOT_PATH}/opt/neon/squashfs_updated"
echo "Update complete"
