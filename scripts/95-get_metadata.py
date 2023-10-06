#!/usr/bin/python3
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

import hashlib
import json
import os
import urllib.request

from sys import argv
from datetime import datetime, timezone


def get_commit_and_time(repo, branch="master"):
    info = urllib.request.urlopen(f"https://api.github.com/repos/neongeckocom/"
                                  f"{repo}/commits?sha={branch}").read()
    last_commit = json.loads(info)[0]
    commit_sha = last_commit.get("sha")
    commit_time = datetime.strptime(last_commit.get("commit").get(
        "committer").get("date"), '%Y-%m-%dT%H:%M:%SZ').replace(
        tzinfo=timezone.utc).timestamp()
    return commit_sha, commit_time


def get_neon_core_meta(core_branch="dev"):
    try:
        core_sha, core_time = get_commit_and_time("neoncore", core_branch)
    except Exception as e:
        print(e)
        core_sha = "Unknown"
        core_time = "Unknown"

    core_version = "unknown"
    try:
        core_version_file = urllib.request.urlopen(
            f"https://raw.githubusercontent.com/neongeckocom/neoncore/"
            f"{core_branch}/neon_core/version.py").read().decode('utf-8')
        for line in core_version_file.split('\n'):
            if line.startswith("__version__"):
                if '"' in line:
                    core_version = line.split('"')[1]
                else:
                    core_version = line.split("'")[1]
        if core_branch not in ("dev", "master"):
            core_version = f"{core_version}*"
    except Exception as e:
        print(e)

    return {"sha": core_sha, "time": core_time, "version": core_version}


def get_recipe_meta(branch="dev"):
    try:
        image_sha, image_time = get_commit_and_time("neon_debos", branch)
    except Exception as e:
        print(e)
        image_sha = "Unknown"
        image_time = "Unknown"
    return {"sha": image_sha, "time": image_time}


def get_initramfs_metadata():
    initramfs_path = "/boot/firmware/initramfs"
    if not os.path.isfile(initramfs_path):
        return dict()
    else:
        with open(initramfs_path, 'rb') as f:
            md5_hash = hashlib.md5(f.read()).hexdigest()
        return {"path": initramfs_path,
                "md5": md5_hash}


def get_kernel_metadata(platform: str) -> dict:
    kernel_version = "unknown"
    if platform == "rpi4":
        kernel_path = "/boot/firmware/kernel8.img"
        kernel_info_path = "/boot/firmware/kernel.txt"
    else:
        return {"version": kernel_version}

    if os.path.isfile(kernel_info_path):
        with open(kernel_info_path, 'r') as f:
            kernel_version = f.read().strip('\n')
    with open(kernel_path, 'rb') as f:
        kernel_hash = hashlib.md5(f.read()).hexdigest()
    return {"version": kernel_version,
            "md5": kernel_hash,
            "filename": os.path.basename(kernel_path)}


if __name__ == "__main__":
    core_ref = argv[1]
    debos_ref = argv[2]
    image_name = argv[3]
    architecture = argv[4]
    platform = argv[5]
    device = argv[6]
    print(f"debos_ref={debos_ref}")
    data = dict()
    data["core"] = get_neon_core_meta(core_ref)
    data["image"] = get_recipe_meta(debos_ref)
    data["image"]["version"] = debos_ref
    data["initramfs"] = get_initramfs_metadata()
    data["kernel"] = get_kernel_metadata(platform)
    data["base_os"] = {
        "name": image_name.split('_', 1)[0],
        "time": datetime.strptime(image_name.split('_', 1)[1],
                                  "%Y-%m-%d_%H_%M").timestamp(),
        "arch": architecture,
        "platform": platform,
        "device": device
    }
    os.makedirs("/opt/neon", exist_ok=True)
    print(f"build_info={data}")
    with open("/opt/neon/build_info.json", "w+") as o:
        json.dump(data, o, indent=2)
        o.write('\n')
