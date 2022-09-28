# OVOS devices

This repo contains [debos](https://github.com/go-debos/debos) recipes for building Open Voice OS development installation images.

## Available recipes

- ovos-dev-edition-rpi4.yml: Open Voice OS image based on Ubuntu 20.04. This aims to be a development edition cutting edge build aimed at developers.

## Build instructions

This will detail the build instructions using the debos docker, if you wish instructions for running debos natively can be found in the [official readme](https://github.com/go-debos/debos#sypnosis)


Fetch the debos docker container

```
docker pull godebos/debos
```

The docker needs some special access so the docker commandline becomes

```sh
docker run --rm --device /dev/kvm --user $(id -u) \
           --group-add=$(getent group kvm | cut -d : -f 3) \
           --workdir /recipes \
           --mount "type=bind,source=$(pwd),destination=/recipes" \
           --security-opt label=disable godebos/debos \
           -e ROOT_DEV:/dev/sda2 \
           RECIPE \
           -m 7450M
```

Where:
- `/dev/sda2` defines the root device, in this case booting from USB
- `RECIPE` is one of the listed recipes above (ex mycroft-mark-2-rpi4-ubuntu.yml)
- `-m` flag defines memory limit allocated to the Docker container
