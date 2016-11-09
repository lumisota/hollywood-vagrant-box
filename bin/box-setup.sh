#!/bin/bash

sudo apt-get install dpkg-dev git -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install gcc-4.9 g++-4.9 -y
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
git clone https://github.com/lumisota/tcp-hollywood-linux.git
cd tcp-hollywood-linux
make deb-pkg LOCALVERSION=-hollywood KDEB_PKGVERSION=$(make kernelversion)-1

