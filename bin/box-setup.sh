#!/bin/bash

# install Hollywood kernel
sudo apt-get install dpkg-dev git -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt-get install gcc-4.9 g++-4.9 -y --force-yes
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

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

# install netperfmeter

add-apt-repository ppa:dreibh/ppa -y
sudo apt-get update
sudo apt-get install netperfmeter -y

# install tapas dependencies

sudo add-apt-repository ppa:mc3man/trusty-media -y
sudo apt-get update
sudo apt-get install python-twisted python-twisted-bin python-twisted-core python-twisted-web gstreamer0.10-plugins-* gstreamer0.10-ffmpeg gstreamer0.10-tools python-gst0.1 libgstreamer0.10-dev python-scipy python-psutil -y

# clean up 

#sudo apt-get clean
#cat /dev/null > ~/.bash_history && history -c
#sudo dd if=/dev/zero of=/EMPTY bs=1M
#sudo rm -f /EMPTY

