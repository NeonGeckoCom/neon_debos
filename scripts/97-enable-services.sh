# Enable Services
(systemctl enable mycroft.service)
(systemctl enable mycroft-messagebus.service)
(systemctl enable mycroft-audio.service)
(systemctl enable mycroft-voice.service)
(systemctl enable mycroft-enclosure.service)
(systemctl enable mycroft-skills.service)
(systemctl enable mycroft-gui.service)
(systemctl enable weston.service)

# Install RPI4 Userland
mkdir -p /tmp/rpi-userland
(cd /tmp/rpi-userland && git clone https://github.com/raspberrypi/userland)
(bash /tmp/rpi-userland/userland/build.sh --aarch64)
