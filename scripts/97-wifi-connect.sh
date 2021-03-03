UGID=32011
USER=mycroft

tar -xzf /var/tmp/wifi-connect-aarch64.tar.gz -C /home/$USER/
(cd /home/$USER/wifi-connect-aarch64 && bash raspbian-install.sh)
