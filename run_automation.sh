#!/bin/bash

# TODO: Build and upload initramfs
# TODO: Kernel?

source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
[ -d "${source_dir}/output" ] || mkdir "${source_dir}/output"
timestamp=$(date '+%Y-%m-%d_%H_%M')
image=${1:?}
branch=${2:?}
output_dir=${3:?}
# TODO: Configurable runner limits
mem_limit=${MEM_LIMIT:-"64G"}
core_limit=${CORE_LIMIT:-32}
chmod ugo+x "${source_dir}/scripts/"*
docker run --rm \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
--name neon_debos_ghaction \
godebos/debos "${image}" -t architecture:arm64 -t image:"${image%.*}_${timestamp}" -t neon_core:"${branch}" -t build_cores:"${core_limit}" -m "${mem_limit}" -c "${core_limit}" || exit 2
mv "${source_dir}/output/"*.img.xz "${output_dir}/${branch}"
mv "${source_dir}/output/"*.squashfs "${output_dir}/updates/${branch}"
echo "completed ${timestamp}"
