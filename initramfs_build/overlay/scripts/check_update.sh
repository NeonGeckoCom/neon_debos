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

log "Applying Update (${UPDATE_FILE})"
# Apply update
mv "${UPDATE_FILE}" "${ROOT_FILE}" && log "Applied updated rootfs from ${UPDATE_FILE}"

# Remove paths explicitly excluded from backup
[ -d "${OVERLAY_PATH}/home/neon/venv" ] && rm -rf "${OVERLAY_PATH}/home/neon/venv" && log "Removed old venv"
[ -d "${OVERLAY_PATH}/opt/neon/old_overlay/old_overlay" ] && rm -rf "${OVERLAY_PATH}/opt/neon/old_overlay/old_overlay" && log "Older backup removed"

# Backup to a directory on the drive root file system
mv "${OVERLAY_PATH}" "${BACKUP_PATH}" && log "Backed up overlay ${OVERLAY_PATH} to ${BACKUP_PATH}"

log_begin_msg "Restoring User Files"
restore_backup "${BACKUP_PATH}" "${OVERLAY_PATH}"
log "User Overlay Restored"

# Restore signal files
log_begin_msg "Restoring signal files"
[ -f "${BACKUP_PATH}/opt/neon/firstboot" ] && mv "${BACKUP_PATH}/opt/neon/firstboot" "${OVERLAY_PATH}/opt/neon/" && log "Restored firstboot flag"
[ -f "${BACKUP_PATH}/opt/neon/do_sj201_config" ] && mv "${BACKUP_PATH}/opt/neon/do_sj201_config" "${OVERLAY_PATH}/opt/neon/" && log "Restored do_sj201_config flag"
[ -f "${BACKUP_PATH}/opt/neon/do_bluetooth_config" ] && mv "${BACKUP_PATH}/opt/neon/do_bluetooth_config" "${OVERLAY_PATH}/opt/neon/" && log "Restored do_bluetooth_config flag"
log_end_msg

# Move any other data to a backup location
mv "${BACKUP_PATH}" "${OVERLAY_PATH}/opt/neon/old_overlay" && log "Archived old overlay"

touch "${OVERLAY_PATH}/opt/neon/squashfs_updated"
log "Update complete"
dmesg > "${OVERLAY_PATH}/var/log/squashfs_update.log"
reboot -f
exit 10