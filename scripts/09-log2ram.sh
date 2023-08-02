#!/bin/bash
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

# Checkout valid log2ram release
git clone https://github.com/azlux/log2ram
cd log2ram || exit 10
git checkout a7d0063

# Do log2ram installation
mkdir -p /usr/local/bin/
install -m 644 log2ram.service /etc/systemd/system/log2ram.service
install -m 644 log2ram-daily.service /etc/systemd/system/log2ram-daily.service
install -m 644 log2ram-daily.timer /etc/systemd/system/log2ram-daily.timer
install -m 755 log2ram /usr/local/bin/log2ram
if [ ! -f /etc/log2ram.conf ]; then
    install -m 644 log2ram.conf /etc/log2ram.conf
fi
install -m 644 uninstall.sh /usr/local/bin/uninstall-log2ram.sh
systemctl enable log2ram.service log2ram-daily.timer

# logrotate
if [ -d /etc/logrotate.d ]; then
    install -m 644 log2ram.logrotate /etc/logrotate.d/log2ram
else
    echo "##### Directory /etc/logrotate.d does not exist. #####"
    echo "#####  Skipping log2ram.logrotate installation.  #####"
fi