#!/bin/bash
source_dir="/home/$USER/neon_debos"
docker run --rm \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
godebos/debos debian-base-image-rpi4.yml -t architecture:arm64 -m 10G -c 6

#sudo chown $USER:$USER "${source_dir}"/*
