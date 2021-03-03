UGID=32011
USER=mycroft

tar -xzf /var/tmp/wifi-connect-aarch64.tar.gz -C /home/$USER/
cd /home/$USER/
wget https://github.com/balena-io/wifi-connect/raw/master/scripts/raspbian-install.sh
bash raspbian-install.sh
