sed -i '/LIBRESPOT_NAME/c\LIBRESPOT_NAME="Neon Mark 2 - '"$(hostname)"'"' /etc/raspotify/conf
systemctl enable uxplay.service
