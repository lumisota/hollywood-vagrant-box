#!/bin/bash

# install Hollywood kernel
sudo apt-get install dpkg-dev git -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install gcc-4.9 g++-4.9 -y --force-yes
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
(git clone https://github.com/lumisota/tcp-hollywood-linux.git) || exit
cd tcp-hollywood-linux
make deb-pkg LOCALVERSION=-hollywood KDEB_PKGVERSION=$(make kernelversion)-1
sudo dpkg -i ../linux-headers-$(make kernelversion)-hollywood-g$(git describe --always)_$(make kernelversion)-1_amd64.deb
sudo dpkg -i ../linux-image-$(make kernelversion)-hollywood-g$(git describe --always)_$(make kernelversion)-1_amd64.deb
sudo cp /vagrant/grub /etc/default/grub
sudo update-grub
export GRUB_CONFIG=`sudo find /boot -name "grub.cfg"`
sudo grub-set-default $(grep 'menuentry ' $GRUB_CONFIG | nl -v 0 | grep "hollywood-g$(git describe --always)'" | cut -c 6)]
cd ..
sudo rm -rf *

# install ffmpeg
sudo apt-get install yasm -y --force-yes
(git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg) || exit
cd ffmpeg
./configure
make
sudo make install
cd ..

# install Mininet

apt-get update
apt-get install clang -y --force-yes
(git clone git://github.com/mininet/mininet) || exit
cd mininet
git checkout -b 2.2.1 2.2.1
cd ..
mininet/util/install.sh -a

# install libcurl

apt-get install libcurl4-openssl-dev -y --force-yes

# clean up 
sudo apt-get clean
cat /dev/null > ~/.bash_history && history -c
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

