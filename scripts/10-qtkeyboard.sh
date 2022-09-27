#!/bin/bash

apt install -y libqt5svg5-dev qt5-qmake qtbase5-dev libqt5quick5
# qml-module-qtquick-virtualkeyboard
git clone https://github.com/qt/qtvirtualkeyboard -b 5.15
cd qtvirtualkeyboard
qmake .
make install .