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

source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo chmod ugo+x "${source_dir}/scripts/"*
mem_limit=${MEM_LIMIT:-"24G"}
core_limit=${CORE_LIMIT:-4}

platform=${1:-rpi4}
[ "${platform}" == "rpi4" ] && kernel_version="6.1.77-gecko+"
[ "${platform}" == "opi5" ] && kernel_version="5.10.110-gecko+"

docker run --rm \
--device /dev/kvm \
--workdir /image_build \
--mount type=bind,source="${source_dir}",destination=/image_build \
--group-add=108 \
--security-opt label=disable \
--name "neon_debos_base_${platform}" \
-m "${mem_limit}" \
--oom-kill-disable \
godebos/debos "base-rootfs.yml" \
-t architecture:arm64 \
-t build_cores:"${core_limit}" \
-t kernel_version:"${kernel_version}" \
-t platform:"${platform}" \
-m "${mem_limit}" \
-c "${core_limit}"
