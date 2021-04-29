# Install OVOS Skills
mkdir -p /home/mycroft/.local/share/mycroft/skills/

(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-ovos-pairing)
(cd /home/mycroft/.local/share/mycroft/skills/skill-ovos-pairing && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-ovos-mycroftgui)
(cd /home/mycroft/.local/share/mycroft/skills/skill-ovos-mycroftgui && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-ovos-homescreen)
(cd /home/mycroft/.local/share/mycroft/skills/skill-ovos-homescreen && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-balena-wifi-setup)
(cd /home/mycroft/.local/share/mycroft/skills/skill-balena-wifi-setup && pip3 install -r requirements.txt)

chown -R 32011:32011 /home/mycroft/.local/share/mycroft/skills/
