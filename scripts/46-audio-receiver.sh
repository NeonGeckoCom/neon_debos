sudo apt-get -y install curl && curl -sL https://dtcooper.github.io/raspotify/install.sh | sh
sed -i '/LIBRESPOT_NAME/c\LIBRESPOT_NAME="Neon Mark 2 - '"$(hostname)"'"' /etc/raspotify/conf
usermod -aG bluetooth pulse
pactl load-module module-bluetooth-discover
pactl load-module module-bluetooth-policy
systemctl enable uxplay.service
systemctl enable raspotify.service
systemctl enable kdeconnect.service
systemctl enable bluetooth.service
systemctl enable bluetooth-agent
