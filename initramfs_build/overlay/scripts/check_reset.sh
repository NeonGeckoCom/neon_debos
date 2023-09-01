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

WRITABLE_PATH=${1}
SIGNAL_FILE="${WRITABLE_PATH}/upperdir/opt/neon/signal_reset_device"

. /scripts/functions

set_up_gpio() {
  echo "23" > /sys/class/gpio/export
  echo "24" > /sys/class/gpio/export
  echo "in" > /sys/class/gpio/gpio23/direction
  echo "in" > /sys/class/gpio/gpio24/direction
  if [ "$(cat /sys/class/gpio/gpio24/value)" = "0" ] && [ "$(cat /sys/class/gpio/gpio23/value)" = "0" ]; then
    log "Reset buttons down"
    touch "${SIGNAL_FILE}"
  fi
}

set_up_gpio || log "Unable to check GPIO"

if [ -f "${SIGNAL_FILE}" ]; then
  log "reset requested"
  rm -rf "${WRITABLE_PATH}/upperdir"
  rm -rf "${WRITABLE_PATH}/workdir"
  rm -rf "/swapfile"
  exit 0
# TODO: Option to power off instead of continuing boot
fi

