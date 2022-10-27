#!/bin/bash

# Set to exit on error
set -Ee

git clone https://invent.kde.org/qt/qt/qtvirtualkeyboard/ -b v5.15.4-lts-lgpl
cd qtvirtualkeyboard || exit 10
mv /opt/qvirtualkeyboardinputcontext_p.cpp src/virtualkeyboard/

mkdir build
cd build || exit 10
qmake .. CONFIG+="lang-all handwriting"
make -j4
make install
cd ../..
rm -rf qtvirtualkeyboard
