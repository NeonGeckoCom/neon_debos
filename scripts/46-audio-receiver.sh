# Raspotify installation script
apt-get -y install curl && curl -sL https://dtcooper.github.io/raspotify/install.sh -o install.sh
## Sudo causes issues in build VM, so strip it out
sed -i '/SUDO="sudo"/c\SUDO=""' install.sh
sh install.sh
# Name the device for Spotify
sed -i '/LIBRESPOT_NAME/c\LIBRESPOT_NAME="Neon Mark 2"' /etc/raspotify/conf
# Set up Bluetooth audio permissions
usermod -aG bluetooth pulse
# Enable all services
systemctl enable uxplay.service
systemctl enable kdeconnect.service
systemctl enable bluetooth.service
systemctl enable raspotify.service
# Start Bluetooth services
echo -e 'power on\pairable on\ndiscoverable on\nscan on\nagent on\ndefault-agent\nexit' | bluetoothctl
