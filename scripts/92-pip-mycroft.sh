# Unpack mycroft-core to user home
# git clone https://github.com/HelloChatterbox/mycroft-lib ./tmp/mycroft-lib
#
# Get latest patches
# (cd /tmp/mycroft-lib && wget https://raw.githubusercontent.com/OpenVoiceOS/OpenVoiceOS/develop/buildroot-external/package/python-mycroft-lib/0001-Add-entry_points-to-install-binaries.patch)
#
# Apply all patches
# (cd /tmp/mycroft-lib && git config user.name "aix")
# (cd /tmp/mycroft-lib && git config user.email "aix.m@outlook.com")
# (cd /tmp/mycroft-lib && git am 0001-Add-entry_points-to-install-binaries.patch)
#
# Install mycroft core
# (cd /tmp/mycroft-lib && pip3 install .[all])

# Add Mycroft helper commands to $PATH
# echo 'source /opt/mycroft/.mycroftrc' >> /home/$USER/.bashrc

(pip3 install git+https://github.com/HelloChatterbox/HolmesV)

mkdir -p /var/log/mycroft
chown -R 32011:32011 /home/mycroft
chown -R 32011:32011 /var/log/mycroft
