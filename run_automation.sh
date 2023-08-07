#!/bin/bash

# TODO: Build and upload initramfs
# TODO: Kernel?

source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
[ -d "${source_dir}/output" ] || mkdir "${source_dir}/output"
timestamp=$(date '+%Y-%m-%d_%H_%M')
image=${1:-"debian-neon-image-rpi4.yml"}
neon_core=${2:-"master"}
mem_limit=${MEM_LIMIT:-"16G"}
core_limit=${CORE_LIMIT:-4}
chmod ugo+x "${source_dir}/scripts/"*
docker run --rm -d \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
--name neon_debos \
godebos/debos "${image}" -t architecture:arm64 -t image:"${image%.*}_${timestamp}" -t neon_core:"${neon_core}" -t build_cores:"${core_limit}" -m "${mem_limit}" -c "${core_limit}" && \
docker logs -f neon_debos
echo "completed ${timestamp}"
chown $USER:$USER "${source_dir}/output/${image%.*}_${timestamp}"*
echo -e "\n"
