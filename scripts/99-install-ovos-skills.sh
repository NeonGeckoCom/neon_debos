# Install OVOS Skills
mkdir -p /home/mycroft/.local/share/mycroft/skills/

(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-ovos-setup skill-ovos-setup.openvoiceos)
(cd /home/mycroft/.local/share/mycroft/skills/skill-ovos-pairing.openvoiceos && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-ovos-mycroftgui skill-ovos-mycroftgui.openvoiceos)
(cd /home/mycroft/.local/share/mycroft/skills/skill-ovos-mycroftgui.openvoiceos && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-ovos-homescreen skill-ovos-homescreen.openvoiceos)
(cd /home/mycroft/.local/share/mycroft/skills/skill-ovos-homescreen.openvoiceos && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-balena-wifi-setup skill-balena-wifi-setup.openvoiceos)
(cd /home/mycroft/.local/share/mycroft/skills/skill-balena-wifi-setup.openvoiceos && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/skill-weather skill-weather.openvoiceos)
(cd /home/mycroft/.local/share/mycroft/skills/skill-weather.openvoiceos && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/MycroftAI/skill-date-time skill-date-time.mycroftai)
(cd /home/mycroft/.local/share/mycroft/skills/skill-date-time.mycroftai && pip3 install -r requirements.txt)
(cd /home/mycroft/.local/share/mycroft/skills && git clone https://github.com/OpenVoiceOS/ovos-skills-info ovos-skills-info.openvoiceos)
(cd /home/mycroft/.local/share/mycroft/skills/ovos-skills-info.openvoiceos && pip3 install -r requirements.txt)

chown -R 32011:32011 /home/mycroft/.local/share/mycroft/skills/
