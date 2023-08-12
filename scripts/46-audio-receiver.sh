#!/bin/bash
export LIBRESPOT_NAME=${1:-"Neon Mark 2"}
# Raspotify installation script
apt-get -y install curl && curl -sL https://dtcooper.github.io/raspotify/install.sh -o install.sh
## Sudo causes issues in build VM, so strip it out
sed -i '/SUDO="sudo"/c\SUDO=""' install.sh
sh install.sh
# Adjust the service file to wait for the network to be online and for avahi-daemon to be running
sed -i '/^Wants=network.target sound.target$/c\Wants=network-online.target sound.target avahi-daemon.service ntp.service' /lib/systemd/system/raspotify.service
sed -i '/^After=network.target sound.target$/c\After=network-online.target sound.target avahi-daemon.service ntp.service' /lib/systemd/system/raspotify.service
# Name the device for Spotify
sed -i '/LIBRESPOT_NAME/c\LIBRESPOT_NAME="Neon Mark 2"' /etc/raspotify/conf
# Set up Bluetooth audio permissions
usermod -aG bluetooth pulse
# Enable all services
systemctl enable uxplay.service
systemctl enable kdeconnect.service
systemctl enable bluetooth.service
systemctl enable raspotify.service
