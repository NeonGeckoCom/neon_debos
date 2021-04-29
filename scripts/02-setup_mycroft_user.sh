#!/bin/sh -x

USER=mycroft
GECOS=mycroft
UGID=32011
PASSWORD=mycroft

DEFGROUPS="tty,sudo,adm,dialout,cdrom,plugdev,audio,dip,video,i2c,input"

echo "I: creating default user $USER"
adduser --gecos $GECOS --disabled-login $USER --uid $UGID

echo "I: set user $USER password to $PASSWORD"
echo "$USER:$PASSWORD" | /usr/sbin/chpasswd

mkdir -p /home/$USER/Music
mkdir -p /home/$USER/Pictures
mkdir -p /home/$USER/Videos
mkdir -p /home/$USER/Downloads
mkdir -p /home/$USER/Documents

# Install default kwallet files
mkdir -p /home/$USER/.local/share
cp -r /etc/skel/.local/kwalletd /home/$USER/.local/share
cp -r /etc/skel/.local/* /home/$USER/.local/

chown -R $UGID:$UGID /home/$USER

usermod -a -G ${DEFGROUPS} ${USER}
