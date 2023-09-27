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

# Set to exit on error
set -Ee

# shellcheck disable=SC2207
# shellcheck disable=SC2010
kernels=($(ls /usr/src | grep linux-headers))
## Append default kernel to the end of the list
#default_kernel="${1}"
#kernels[${#kernels[@]}]="${default_kernel}"

for kernel in "${kernels[@]}"; do
  echo "patching kernel ${kernel}"
  export HEADER_DIR="/usr/src/${kernel}"
  [ -d "${HEADER_DIR}" ] || exit 2
  [ -d "${HEADER_DIR}/scripts" ] || continue
  find "$HEADER_DIR/scripts" -type f | while read i; do if file -b $i | egrep -q "^ELF.*x86-64"; then rm "$i"; fi; done
  cd "$HEADER_DIR/scripts" || exit 2
  gcc kallsyms.c -o "$HEADER_DIR/scripts/kallsyms"
  gcc recordmcount.c -o "$HEADER_DIR/scripts/recordmcount"
  gcc unifdef.c -o "$HEADER_DIR/scripts/unifdef"
  gcc ./basic/fixdep.c -o "$HEADER_DIR/scripts/basic/fixdep" || exit 10
  gcc extract-cert.c -o "$HEADER_DIR/scripts/extract-cert" -lssl -lcrypto
  gcc ./mod/modpost.c ./mod/file2alias.c ./mod/sumversion.c -o "$HEADER_DIR/scripts/mod/modpost"
  gcc ./mod/mk_elfconfig.c -o "$HEADER_DIR/scripts/mod/mk_elfconfig"
  gcc  -I../include asn1_compiler.c -o "$HEADER_DIR/scripts/asn1_compiler"
  gcc ./genksyms/genksyms.c ./genksyms/parse.tab.c ./genksyms/lex.lex.c -o "$HEADER_DIR/scripts/genksyms/genksyms"
done

