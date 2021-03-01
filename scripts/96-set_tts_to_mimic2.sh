# If the local Mimic2 cache overlay has been included, 
# the default TTS module must be set to mimic2 for it to be used.

UGID=32011
USER=mycroft

MYCROFT_CONF_PATH="/home/$USER/.mycroft/mycroft.conf"
(cat $MYCROFT_CONF_PATH || echo "{}") | jq '. + {"tts": {"module": "mimic2"}}' > /tmp/mycroft.conf
cp /tmp/mycroft.conf $MYCROFT_CONF_PATH
chown mycroft:mycroft $MYCROFT_CONF_PATH
