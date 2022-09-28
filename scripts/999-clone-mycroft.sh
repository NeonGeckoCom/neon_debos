UGID=32011
USER=mycroft

dpkg --install /var/tmp/mimic.deb

# Unpack mycroft-core-setup-aarch64.tar.gz to user home
git clone https://github.com/MycroftAI/mycroft-core ./home/$USER/

# Get latest patches
(cd /home/$USER/mycroft-core && wget https://raw.githubusercontent.com/OpenVoiceOS/OpenVoiceOS/develop/buildroot-external/package/python-mycroft/0001-Bump-requests-requirement-to-2.24.0-inline-with-buil.patch)
(cd /home/$USER/mycroft-core && wget https://raw.githubusercontent.com/OpenVoiceOS/OpenVoiceOS/develop/buildroot-external/package/python-mycroft/0002-Shut-up.patch)
(cd /home/$USER/mycroft-core && wget https://raw.githubusercontent.com/OpenVoiceOS/OpenVoiceOS/develop/buildroot-external/package/python-mycroft/0003-OVOS-PR2843.patch)
(cd /home/$USER/mycroft-core && wget https://raw.githubusercontent.com/OpenVoiceOS/OpenVoiceOS/develop/buildroot-external/package/python-mycroft/0004-OVOS-enclosure_assumptions.patch)

# Apply all patches
(cd /home/$USER/mycroft-core && git am 0001-Bump-requests-requirement-to-2.24.0-inline-with-buil.patch)
(cd /home/$USER/mycroft-core && git am 0002-Shut-up.patch)
(cd /home/$USER/mycroft-core && git am 0003-OVOS-PR2843.patch)
(cd /home/$USER/mycroft-core && git am 0004-OVOS-enclosure_assumptions.patch)

# Install mycroft core
(cd /home/$USER/mycroft-core && bash dev_setup.sh)

# Add Mycroft helper commands to $PATH
echo 'source /opt/mycroft/.mycroftrc' >> /home/$USER/.bashrc

mkdir -p /opt/mycroft/skills
mkdir -p /var/log/mycroft
mkdir -p /home/$USER/.mycroft

chown -R $UGID:$UGID /home/$USER
chown -R $UGID:$UGID /opt/mycroft
chown -R $UGID:$UGID /var/log/mycroft
