#!/bin/bash

ip route | grep default

if [ $? != 0 ]; then
  wifi-connect  --portal-ssid Neon
fi
