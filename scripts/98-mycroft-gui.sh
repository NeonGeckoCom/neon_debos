UGID=32011
USER=mycroft

cd /home/$USER
git clone https://github.com/MycroftAI/mycroft-gui
git clone https://github.com/OpenVoiceOS/mycroft-embedded-shell/

cd /home/$USER/mycroft-gui
echo " "
echo "Building Mycroft GUI"
if [[ ! -d build-testing ]] ; then
mkdir build-testing
fi
cd build-testing
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make -j4
sudo make install

cd /home/$USER/mycroft-embedded-shell
echo " "
echo "Building Mycroft Embedded Shell"
if [[ ! -d build-testing ]] ; then
mkdir build-testing
fi
cd build-testing
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make -j4
sudo make install

chown -R $UGID:$UGID /home/$USER
