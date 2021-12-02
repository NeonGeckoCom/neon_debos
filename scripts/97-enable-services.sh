# Enable Services
(systemctl enable mycroft.service)
(systemctl enable mycroft-messagebus.service)
(systemctl enable mycroft-audio.service)
(systemctl enable mycroft-voice.service)
(systemctl enable mycroft-enclosure-gui.service)
(systemctl enable mycroft-skills.service)
(systemctl enable mycroft-gui.service)

(apt purge -y netplan.io)
(apt install -y network-manager)

(systemctl disabled systemd-resolved)
(systemctl mask systemd-resolved)
(systemctl stop systemd-networkd.socket)
(systemctl disable systemd-networkd.socket)
(systemctl stop systemd-networkd)
(systemctl disable systemd-networkd)
(systemctl enable network-manager)
