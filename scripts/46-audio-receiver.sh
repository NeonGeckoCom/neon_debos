sed -i '/LIBRESPOT_NAME/c\LIBRESPOT_NAME="Neon Mark 2 - '"$(hostname)"'"' /etc/raspotify/conf
pactl load-module module-bluetooth-discover
pactl load-module module-bluetooth-policy
systemctl enable uxplay.service
systemctl enable kdeconnect.service
systemctl enable bluetooth.service
systemctl enable bluetooth-agent
