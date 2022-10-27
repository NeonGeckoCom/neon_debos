#!/bin/bash

adduser admin -gecos "" --disabled-password
echo "admin:password" | chpasswd
passwd --expire admin
usermod -aG sudo admin
