# Install OVOS PocketSphinx Plugin
(echo "**** Installing OVOS Pocketspinx Plugin ****")
(sudo pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx)

#Install Tflite-Runtime or core does not build
(echo "**** Install Tflite Runtime ****")
(sudo pip3 install tflite_runtime)
(sudo pip3 install tflit)
(sudo pip3 install sonopy==0.1.2)

# Install OVOS Precise Lite Plugin
(echo "**** Installing OVOS Precise Lite Plugin ****")
(sudo pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite)

# Install & Update OVOS Local Backend
(echo "**** Install OVOS Local Backend****")
(sudo pip3 install git+https://github.com/OpenVoiceOS/OVOS-local-backend)

mkdir -p /var/log/mycroft
chown -R 32011:32011 /home/mycroft
chown -R 32011:32011 /var/log/mycroft
