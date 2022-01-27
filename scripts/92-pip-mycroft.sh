#Install Wheel
(echo "**** Install Wheel ****")
(pip3 install wheel)

#Install Tflite-Runtime or core does not build
(echo "**** Install Tflite Runtime ****")
(pip3 install tflite_runtime)

#Install Json Database
(echo "**** Install Json Database ****")
(pip3 install git+https://github.com/HelloChatterbox/json_database)

# Install & Update OVOS Utils
(echo "**** Install OVOS Utils****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos_utils)

# Install & Update OVOS Workshop
(echo "**** Install OVOS Workshop****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-workshop)

# Install & Update OVOS Local Backend
(echo "**** Install OVOS Local Backend****")
(pip3 install git+https://github.com/OpenVoiceOS/OVOS-local-backend)

# Install OVOS Notifications Service
(echo "**** Installing Notifications Service ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos_notifications_service)

# Install OVOS Mimic2 Plugin
(echo "**** Installing OVOS Mimic-2 Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic2)

# Install OVOS Mimic Plugin
(echo "**** Installing OVOS Mimic Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-mimic)

# Install OVOS VLC Plugin
(echo "**** Installing OVOS VLC Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-vlc-plugin)

# Install OVOS OCP Audio Plugin
(echo "**** Installing OVOS OCP Audio Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-ocp-audio-plugin)

# Install OVOS OCP Audio Plugin
(echo "**** Installing OVOS Pico TTS Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-tts-plugin-pico)

# Install OVOS OCP Audio Plugin
(echo "**** Installing Neon Larynx TTS Plugin ****")
(pip3 install git+https://github.com/NeonGeckoCom/neon-tts-plugin-larynx_server)

# Install OVOS Precise Lite Plugin
(echo "**** Installing OVOS Precise Lite Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite)

# Install OVOS Precise Lite Plugin
(echo "**** Installing OVOS Pocketspinx Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx)

# Install OVOS Core
(echo "**** Installing OVOS CORE ****")
(pip3 install https://github.com/OpenVoiceOS/ovos-core/archive/playground/0.0.2.zip#egg=ovos-core[all])

# Install OVOS Plugin Manager
(echo "**** Installing OVOS Plugin Manager ****")
(pip3 install https://github.com/openvoiceos/ovos-plugin-manager/archive/dev.zip)

# Install Requests Cache
(echo "**** Installing Request Cache ****")
(pip3 install requests_cache)

# Install OVOS Bus metapackage
(echo "**** Installing ovos-gui ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-bus)

# Install OVOS GUI metapackage
(echo "**** Installing ovos-gui ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-gui)

# Install OVOS Skills metapackage
(echo "**** Installing ovos-skills ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-skills)

# Install OVOS Audio metapackge
(echo "**** Installing ovos-audio ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-audio)

# Install OVOS Speech metapackage
(echo "**** Installing ovos-speech ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-speech)

mkdir -p /var/log/mycroft
chown -R 32011:32011 /home/mycroft
chown -R 32011:32011 /var/log/mycroft
