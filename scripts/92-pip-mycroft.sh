#Install Wheel
(echo "**** Install Wheel ****")
(pip3 install wheel)

#Install Json Database
(echo "**** Install Json Database ****")
(pip3 install git+https://github.com/HelloChatterbox/json_database)

# Install & Update OVOS Utils
(echo "**** Install OVOS Utils****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos_utils)

# Install & Update OVOS Workshop
(echo "**** Install OVOS Workshop****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-workshop)

#Install Minimal Core Dependencies Manually
(echo "**** Install Tflite Runtime ****")
(pip3 install requests>=2.20.0,<2.26.0)
(pip3 install PyAudio~=0.2.11)
(pip3 install pyee~=8.1)
(pip3 install SpeechRecognition~=3.8.1)
(pip3 install tornado~=6.0, >=6.0.3)
(pip3 install psutil~=5.6.6)
(pip3 install python-dateutil~=2.6.0)
(pip3 install combo-lock~=0.2)
(pip3 install PyYAML~=5.4)
(pip3 install ovos-lingua-franca~=0.4.3a1)
(pip3 install mock_msm~=0.9.2)
(pip3 install mycroft-messagebus-client~=0.9.1,!=0.9.2,!=0.9.3)
(pip3 install adapt-parser~=0.5)
(pip3 install padatious~=0.4.8)
(pip3 install fann2==1.0.7)
(pip3 install padaos~=0.1)
(pip3 install pyxdg~=0.26)

# Install OVOS Core
(echo "**** Installing OVOS CORE ****")
(pip3 install ovos-core==0.0.2a3)

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

# Install OVOS Precise Lite Plugin
(echo "**** Installing OVOS Precise Lite Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-precise-lite)

# Install OVOS PocketSphinx Plugin
(echo "**** Installing OVOS Pocketspinx Plugin ****")
(pip3 install git+https://github.com/OpenVoiceOS/ovos-ww-plugin-pocketsphinx)

#Install Tflite-Runtime or core does not build
(echo "**** Install Tflite Runtime ****")
(pip3 install tflite_runtime)

mkdir -p /var/log/mycroft
chown -R 32011:32011 /home/mycroft
chown -R 32011:32011 /var/log/mycroft
