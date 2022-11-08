#!/bin/bash

# Set to exit on error
set -Ee

dpkg --force-overwrite -i /opt/qtvirtualkeyboard_5.15.6_arm64.deb
rm /opt/qtvirtualkeyboard*