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

. /scripts/functions

# Validate update and optionally create backup
if [ ! -f "${UPDATE_FILE}" ]; then
  log "No update (${UPDATE_FILE})"
  exit 0
elif [ -n "${BACKUP_FILE}" ]; then
  mv "${ROOT_FILE}" "${BACKUP_FILE}" && log "Backed up existing image ${ROOT_FILE} to ${BACKUP_FILE}"
fi

# Apply update
mv "${UPDATE_FILE}" "${ROOT_FILE}" && log "Applied updated rootfs from ${UPDATE_FILE}"

# Backup to a directory on the drive root file system
mv "${OVERLAY_PATH}" "${BACKUP_PATH}" && log "Backed up overlay ${OVERLAY_PATH} to ${BACKUP_PATH}"

# Ensure paths exist for migrated data
mkdir -p "${OVERLAY_PATH}/etc/NetworkManager"
mkdir -p "${OVERLAY_PATH}/etc/ssh"
mkdir -p "${OVERLAY_PATH}/opt/neon"
mkdir -p "${OVERLAY_PATH}/var"

# Migrate specific data back
rm -rf "${BACKUP_PATH}/home/neon/venv" && log "Removed old venv"

mv "${BACKUP_PATH}/etc/NetworkManager/system-connections" "${OVERLAY_PATH}/etc/NetworkManager/" && log "Restored Networks"
mv "${BACKUP_PATH}/etc/ssh/"ssh_host_*_key* "${OVERLAY_PATH}/etc/ssh/" && log "Restored SSH keys" || log "No SSH keys to restore"
[ -f "${BACKUP_PATH}/etc/shadow" ] && mv "${BACKUP_PATH}/etc/shadow" "${OVERLAY_PATH}/etc/" && log "Restored User Passwords"
[ -f "${BACKUP_PATH}/etc/hostname" ] && mv "${BACKUP_PATH}/etc/hostname" "${OVERLAY_PATH}/etc/" && log "Restored Hostname"
mv "${BACKUP_PATH}/etc/machine-id" "${OVERLAY_PATH}/etc/" && log "Restored machine-id"
mv "${BACKUP_PATH}/home" "${OVERLAY_PATH}/" && log "Restored /home"
mv "${BACKUP_PATH}/root" "${OVERLAY_PATH}/" && log "Restored /root"

# Restore signal files
[ -f "${BACKUP_PATH}/opt/neon/firstboot" ] && mv "${BACKUP_PATH}/opt/neon/firstboot" "${OVERLAY_PATH}/opt/neon/" && log "Restored firstboot flag"
[ -f "${BACKUP_PATH}/opt/neon/do_sj201_config" ] && mv "${BACKUP_PATH}/opt/neon/do_sj201_config" "${OVERLAY_PATH}/opt/neon/" && log "Restored do_sj201_config flag"
[ -f "${BACKUP_PATH}/opt/neon/do_bluetooth_config" ] && mv "${BACKUP_PATH}/opt/neon/do_bluetooth_config" "${OVERLAY_PATH}/opt/neon/" && log "Restored do_bluetooth_config flag"

# Restore specific `/var` paths (https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch05.html)
[ -d "${BACKUP_PATH}/var/games" ] && mv "${BACKUP_PATH}/var/games" "${OVERLAY_PATH}/var/" && log "Restored /var/games"
[ -d "${BACKUP_PATH}/var/log" ] && mv "${BACKUP_PATH}/var/log" "${OVERLAY_PATH}/var/" && log "Restored /var/log"
[ -d "${BACKUP_PATH}/var/mail" ] && mv "${BACKUP_PATH}/var/mail" "${OVERLAY_PATH}/var/" && log "Restored /var/mail"

# Exclude crash information that relates to a previous OS
#[ -d "${BACKUP_PATH}/var/crash" ] && mv "${BACKUP_PATH}/var/crash" "${OVERLAY_PATH}/var/" && log "Restored /var/crash"

# Exclude package-specific data as the installed packages/versions may have changed
#[ -d "${BACKUP_PATH}/var/lib" ] && mv "${BACKUP_PATH}/var/lib" "${OVERLAY_PATH}/var/" && log "Restored /var/lib"

# Move any other data to a backup location
mv "${BACKUP_PATH}" "${OVERLAY_PATH}/opt/neon/old_overlay" && log "Archived old overlay"

touch "${OVERLAY_PATH}/opt/neon/squashfs_updated"
log "Update complete"
