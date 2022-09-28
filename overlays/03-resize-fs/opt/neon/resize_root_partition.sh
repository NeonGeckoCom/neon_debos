#!/bin/bash

growpart /dev/sda 2
resize2fs /dev/sda2
rm /opt/neon/resize_fs