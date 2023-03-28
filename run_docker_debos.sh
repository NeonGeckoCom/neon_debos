#!/bin/bash
source_dir="/home/$USER/neon_debos"
timestamp=$(date '+%Y-%m-%d_%H_%M')
image="debian-neon-image-rpi4"
sudo chmod ugo+x "${source_dir}/scripts/"*
docker run --rm -d \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
--name neon_debos \
godebos/debos "${image}.yml" -t architecture:arm64 -t image:"${image}_${timestamp}.img" -m 24G -c 4 && \
docker logs -f neon_debos

#sudo chown $USER:$USER "${source_dir}"/*
