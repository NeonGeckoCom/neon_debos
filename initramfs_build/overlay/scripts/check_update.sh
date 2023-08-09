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

OVERLAY_PATH=${1}
UPDATE_FILE=${2}
ROOT_FILE=${3}
BACKUP_PATH=${4}
BACKUP_FILE=${5:-""}

# Validate update and optionally create backup
if [ ! -f "${UPDATE_FILE}" ]; then
  echo "No update (${UPDATE_FILE})"
  exit 0
elif [ -n "${BACKUP_FILE}" ]; then
  mv "${ROOT_FILE}" "${BACKUP_FILE}" && echo "Backed up existing image"
fi

# Apply update
mv "${UPDATE_FILE}" "${ROOT_FILE}" && echo "Applied updated rootfs"

# Create temporary backup directory on the drive root file system
mkdir "${BACKUP_PATH}"
mv "${OVERLAY_PATH}/"* "${BACKUP_PATH}/" && echo "Backed up overlay"

# Ensure paths exist for migrated data
[ -d "${OVERLAY_PATH}/etc/NetworkManager" ] || mkdir -p "${OVERLAY_PATH}/etc/NetworkManager"
[ -d "${OVERLAY_PATH}/etc/ssh" ] || mkdir -p "${OVERLAY_PATH}/etc/ssh"
[ -d "${OVERLAY_PATH}/home" ] || mkdir -p "${OVERLAY_PATH}/home"
[ -d "${OVERLAY_PATH}/opt/neon" ] || mkdir -p "${OVERLAY_PATH}/opt/neon"


# Migrate specific data back
mv "${BACKUP_PATH}/etc/NetworkManager/system-connections" "${ROOT_PATH}/etc/NetworkManager/" && echo "Restored Networks"
mv "${BACKUP_PATH}/etc/ssh/"ssh_host_*_key* "${ROOT_PATH}/etc/ssh/" && echo "Restored SSH keys"
mv "${BACKUP_PATH}/etc/shadow" "${ROOT_PATH}/etc/shadow"
mv "${BACKUP_PATH}/etc/machine-id" "${ROOT_PATH}/etc/machine-id"
mv "${BACKUP_PATH}/home" "${ROOT_PATH}/home" && rm -rf "${ROOT_PATH}/home/neon/venv"
mv "${BACKUP_PATH}/var" "${ROOT_PATH}/var" && echo "Restored /var"
mv "${BACKUP_PATH}/root" "${ROOT_PATH}/root" && echo "Restored /root"

# Move any other data to a backup location
mv "${BACKUP_PATH}" "${ROOT_PATH}/opt/neon/old_overlay"

touch "${OVERLAY_PATH}/opt/neon/squashfs_updated"
echo "Update complete"
