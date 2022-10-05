#!/bin/bash
source_dir="/home/$USER/neon_debos"
sudo chmod ugo+x "${source_dir}/scripts/"*
docker run --rm -d \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
-t debos \
godebos/debos debian-base-image-rpi4.yml -t architecture:arm64 -m 12G -c 6 && \
docker logs -f debos

#sudo chown $USER:$USER "${source_dir}"/*
