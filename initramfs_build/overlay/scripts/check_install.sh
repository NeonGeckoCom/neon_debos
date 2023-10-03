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

set -e
. /scripts/functions
rootpart=$(realpath "$ROOT")
root_uuid="77d9d0ad-c9a4-a94a-b477-ce3a3e8534e8"
boot_uuid="3030-3030"

# TODO: Conditional check to enable installation

# Check if booting from micro SD
[ "${rootpart}" = "/dev/mmcblk0p2" ] || exit 0
log "Booted from SD Card. Checking for installation"

if lsblk -o UUID | grep -q "3030-3030"; then
  log "Already installed to internal storage. Try next boot device"
  exit 11
else
  log "Installing OS to internal storage"
  # TODO: Display installation screen
fi

# Write image to internal storage
sleep 5
last_sector=$(fdisk -l /dev/mmcblk0 | grep p2 | awk '{print $4}')
log "Writing ${last_sector} sectors"
sleep 5
dd if=/dev/mmcblk0 of=/dev/mmcblk1 count=${last_sector} && log "Wrote image to internal storage"
sleep 5
# Guarantee unique partition UUIDs
printf "\x30\x30\x30\x30" | dd bs=1 seek=67 count=4 conv=notrunc of=/dev/mmcblk1p1 && log "Changed boot partition UUID to ${boot_uuid}"
tune2fs -U "${root_uuid}" /dev/mmcblk1p2 && lo9g "Changed root partition UUID to ${root_uuid}"

# Update labels in boot config
[ -d /media/fw ] || mkdir /media/fw
real_path="/media/fw"
mount boot_uuid=${boot_uuid} "${real_path}"
sed -i -e "s|^rootdev=boot_uuid=*$|rootdev=boot_uuid=${root_uuid}|g"  ${real_path}/orangepiEnv.txt
umount ${real_path}

log "Installed OS to internal storage"
dmesg > "${OVERLAY_PATH}/var/log/os_installation.log"
reboot -f
exit 10
