#!/bin/bash
# NEON AI (TM) SOFTWARE, Software Development Kit & Application Framework
# All trademark and other rights reserved by their respective owners
# Copyright 2008-2022 Neongecko.com Inc.
# Contributors: Daniel McKnight, Guy Daniels, Elon Gasper, Richard Leeds,
# Regina Bloomstine, Casimiro Ferreira, Andrii Pernatii, Kirill Hrymailo
# BSD-3 License
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from this
#    software without specific prior written permission.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS;  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE,  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

read -rsp "Password: " pass
echo -e "\n"
source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
[ -d "${source_dir}/output" ] || mkdir "${source_dir}/output"
timestamp=$(date '+%Y-%m-%d_%H_%M')
image=${1:-"debian-neon-image.yml"}
neon_core=${2:-"master"}
platform=${3:-"rpi4"}
device=${4:-"mark_2"}
mem_limit=${MEM_LIMIT:-"16G"}
core_limit=${CORE_LIMIT:-4}
debos_version="$(python3 "${source_dir}/version.py")*"
echo "Building core=${neon_core} version=${debos_version} platform=${platform}"
echo "${pass}" | sudo -S chmod ugo+x "${source_dir}/scripts/"*

[ "${platform}" == "rpi4" ] && kernel_version="6.1.77-gecko+"
[ "${platform}" == "opi5" ] && kernel_version="5.10.110-gecko+"

if [ ! -f "${source_dir}/${platform}_base.tar.gz" ]; then
  echo "Building base image"
  bash "${source_dir}/build_base_image.sh" "${platform}"
  echo "Completed base image"
fi
docker run --rm -d \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
--name neon_debos \
godebos/debos "${image}" \
-t device:"${device}" \
-t architecture:arm64 \
-t platform:"${platform}" \
-t image:"${image%.*}-${platform}_${timestamp}" \
-t neon_core:"${neon_core}" \
-t neon_debos:"${debos_version}" \
-t build_cores:"${core_limit}" \
-t kernel_version:"${kernel_version}" \
-m "${mem_limit}" \
-c "${core_limit}" && \
docker logs -f neon_debos
echo "completed ${timestamp}"
echo "${pass}" | sudo -S chown $USER:$USER "${source_dir}/output/${image%.*}-${platform}_${timestamp}"*
echo -e "\n"
