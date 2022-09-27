#!/bin/bash

docker run --rm \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source=/home/$USER/PycharmProjects/neon_debos,destination=/image_build \
--group-add=108 \
--security-opt label=disable \
godebos/debos debian-base-image-rpi4.yml -t architecture:arm64 -m 10G -c 6
