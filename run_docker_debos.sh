#!/bin/bash
source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir "${source_dir}/output"
timestamp=$(date '+%Y-%m-%d_%H_%M')
image=${1:-"debian-neon-image-rpi4.yml"}
neon_core=${2:-"master"}
sudo chmod ugo+x "${source_dir}/scripts/"*
docker run --rm -d \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
--name neon_debos \
godebos/debos "${image}" -t architecture:arm64 -t image:"${image%.*}_${timestamp}" -t neon_core:"${neon_core}" -m 24G -c 4 && \
docker logs -f neon_debos

#sudo chown $USER:$USER "${source_dir}"/*
