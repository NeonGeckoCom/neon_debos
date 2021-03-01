UGID=32011
USER=mycroft

# Unpack mycroft-core-setup-aarch64.tar.gz to user home
tar -xzf /var/tmp/mycroft-core-setup.tar.gz -C /home/$USER/
rm /var/tmp/mycroft-core-setup.tar.gz

# Add Mycroft helper commands to $PATH
echo 'source /opt/mycroft/.mycroftrc' >> /home/$USER/.bashrc

mkdir -p /opt/mycroft/skills
mkdir -p /var/log/mycroft
mkdir -p /home/$USER/.mycroft

chown -R $UGID:$UGID /home/$USER
chown -R $UGID:$UGID /opt/mycroft
chown -R $UGID:$UGID /var/log/mycroft
