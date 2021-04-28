UGID=32011
USER=mycroft

# Unpack mycroft-core to user home
git clone https://github.com/HelloChatterbox/mycroft-lib/ ./home/$USER/

# Get latest patches
(cd /home/$USER/mycroft-lib && wget https://github.com/OpenVoiceOS/OpenVoiceOS/blob/develop/buildroot-external/package/python-mycroft-lib/0001-Add-entry_points-to-install-binaries.patch)

# Apply all patches
(cd /home/$USER/mycroft-lib && git am 0001-Add-entry_points-to-install-binaries.patch)

# Install mycroft core
pip install .[all]

# Add Mycroft helper commands to $PATH
# echo 'source /opt/mycroft/.mycroftrc' >> /home/$USER/.bashrc

mkdir -p /var/log/mycroft

chown -R $UGID:$UGID /home/$USER
chown -R $UGID:$UGID /var/log/mycroft
