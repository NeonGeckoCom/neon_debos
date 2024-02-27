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

BASE_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${BASE_DIR}" || exit 10

CORE_REF="${1:-dev}"

# Remove sj201 dtoverlays
# TODO: This is patching some LED issues on SJ201R10; ideally, the button and
#       fan overlays would remain and the PHAL plugins integrate with them
rm /boot/firmware/overlays/sj201-buttons-overlay.dtbo
rm /boot/firmware/overlays/sj201-rev10-pwm-fan-overlay.dtbo

# TODO: Configurable username/venv path
# Configure venv for deepspeech compat.
python3.10 -m venv "/home/neon/venv" || exit 10
. /home/neon/venv/bin/activate
pip install --upgrade pip wheel
mv /home/neon/pip /home/neon/venv/bin/pip
chmod ugo+x /home/neon/venv/bin/pip

# Install core and skills
export NEON_IN_SETUP="true"
# TODO: Normalize extras after NeonCore 24.2.x stable release
pip install --use-pep517 "neon-core[core_modules,skills_required,skills_essential,skills_default,skills_extended,pi] @ git+https://github.com/neongeckocom/neoncore@${CORE_REF}" || exit 11
echo "Core Installed"
neon-install-default-skills && echo "Default git skills installed" || exit 2

# Clean pip caches
rm -rf /root/.cache/pip

# Download model files
mkdir -p /home/neon/.local/share/neon
wget -O /home/neon/.local/share/neon/vosk-model-small-en-us-0.15.zip https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip
cd /home/neon/.local/share/neon || exit 10
unzip vosk-model-small-en-us-0.15.zip
rm vosk-model-small-en-us-0.15.zip

# Precise engine and models
cd /home/neon/.local/share || exit 10
wget https://github.com/MycroftAI/mycroft-precise/releases/download/v0.3.0/precise-engine_0.3.0_aarch64.tar.gz
tar xvf precise-engine_0.3.0_aarch64.tar.gz && echo "precise engine unpacked"
rm precise-engine_0.3.0_aarch64.tar.gz

cd neon || exit 10
wget https://github.com/MycroftAI/precise-data/raw/models-dev/hey-mycroft.tar.gz
tar xvf hey-mycroft.tar.gz && echo "ww model unpacked"

export XDG_CONFIG_HOME="/home/neon/.config"
export XDG_DATA_HOME="/home/neon/.local/share"
export XDG_CACHE_HOME="/home/neon/.cache"

# TODO: Below init neon_core default fallbacks but CLIs should add an option to init configured fallbacks
# Init TTS model
neon-audio init-plugin -p coqui || echo "Failed to init TTS"
# Init STT model
neon-speech init-plugin -p ovos-stt-plugin-vosk || echo "Failed to init STT"

ln -s /home/neon/.local/state/neon /home/neon/logs
rm /home/neon/.local/state/neon/.keep
rm /home/neon/.config/neon/.keep
# Fix home directory permissions
chown -R neon:neon /home/neon

# Ensure executable
chmod +x /opt/neon/*.sh
chmod +x /usr/sbin/*
chmod +x /usr/bin/*
chmod +x /usr/libexec/*
chmod +x /opt/neon/install_skills

# Disable wifi-connect
systemctl disable wifi-setup.service

# Enable services
systemctl enable neon.service
systemctl enable neon-admin-enclosure.service
systemctl enable neon-audio.service
systemctl enable neon-bus.service
systemctl enable neon-enclosure.service
systemctl enable neon-gui.service
systemctl enable neon-logs.service
systemctl enable neon-skills.service
systemctl enable neon-speech.service

neon_uid=$(id -u neon)
echo "XDG_RUNTIME_DIR=/run/user/${neon_uid}" >> /etc/neon/neon_env.conf
echo "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${neon_uid}/bus" >> /etc/neon/neon_env.conf

# Setup Completed
echo "Setup Complete"
