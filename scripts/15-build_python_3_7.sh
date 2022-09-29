#!/bin/bash
cd /opt || exit 10
wget https://www.python.org/ftp/python/3.7.14/Python-3.7.14.tar.xz
tar -xf Python-3.7.14.tar.xz
cd Python-3.7.14 || exit 10
./configure --enable-optimizations --enable-shared && echo "Configure complete"
echo ">>>configure finished"
make -j8 && echo "make complete"
echo ">>>make finished"
make altinstall && echo "install complete"
echo ">>>altinstall finished"
ldconfig /opt/Python-3.7.14 && echo "python-3.7 libs linked"
# TODO: Can /opt/Python-3.7.* be removed?
