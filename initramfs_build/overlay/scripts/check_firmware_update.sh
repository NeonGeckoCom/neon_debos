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

. /scripts/functions

BACKUP_PATH=${1}


cleanup() {
  if [ -z "$(ls "${real_path}")" ]; then
    log "cleanup after FW update check"
    return 0
  fi
  log_failure_msg "Update error. rolling back boot partition changes"
  [ -d "${BACKUP_PATH}" ] || exit 10
  [ -f "${BACKUP_PATH}/${KERNEL}" ] && mv "${BACKUP_PATH}/${KERNEL}" "${real_path}" && echo "restored kernel"
  mv "${BACKUP_PATH}/"*.dtb "${real_path}/" && echo "restored dtb files"
  [ -d "${BACKUP_PATH}/overlays" ] && mv "${BACKUP_PATH}/overlays" "${real_path}" && echo "restored overlays"
  umount "${real_path}"
  dmesg > "/media/rw/upperdir/var/log/firmware_update.log"
}

set -e
trap cleanup EXIT


[ -d /media/fw ] || mkdir /media/fw
real_path="/media/fw"
mount LABEL=firmware "${real_path}"

# Get current kernel md5
old_md5=$(md5sum "${real_path}/${KERNEL}" | cut -d' ' -f1)

# Get update kernel md5
update_path="/media/ro/boot"
[ -d "${update_path}/firmware" ] && update_path=${update_path}/firmware
new_md5=$(md5sum "${update_path}/${KERNEL}" | cut -d' ' -f1)

if [ "${old_md5}" = "${new_md5}" ]; then
  log "kernel unchanged"
  umount "${real_path}"
  return 0
fi

log "Kernel update (old=${old_md5}|new=${new_md5})"

# Prep backup path
[ -d "${BACKUP_PATH}" ] && rm -rf "${BACKUP_PATH}"
mkdir "${BACKUP_PATH}"

# Backup old firmware
mv "${real_path}/${KERNEL}" "${BACKUP_PATH}" && log "backed up kernel"
mv "${real_path}/"*.dtb "${BACKUP_PATH}/" && log "backed up dtb files"
mv "${real_path}/overlays" "${BACKUP_PATH}/" && log "backed up overlays directory"
log "Backed up to ${BACKUP_PATH}"

# Copy new firmware
new_version=$(strings "${update_path}/${KERNEL}" | grep "Linux version" | head -n1 | cut -d' ' -f3)
log "New kernel version=${new_version}"
# TODO: This path not found
cp "/media/ro/usr/lib/linux-image-${new_version}/broadcom/"*.dtb "${real_path}" && log "Updated broadcom FW"
cp -r "/media/ro/usr/lib/linux-image-${new_version}/overlays" "${real_path}" && log "Updated dtb overlays"
cp "${update_path}/${KERNEL}" "${real_path}/${KERNEL}" && log "Updated kernel"

# Unmount and reboot
umount "${real_path}"
log "Firmware update complete"
dmesg > "/media/rw/upperdir/var/log/firmware_update.log"
reboot -f
exit 10
