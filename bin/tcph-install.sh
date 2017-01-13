#!/bin/bash

(git clone https://github.com/lumisota/tcp-hollywood-linux.git) || exit
cd tcp-hollywood-linux
git checkout $1
make deb-pkg LOCALVERSION=-hollywood KDEB_PKGVERSION=$(make kernelversion)-1
sudo dpkg -i ../linux-headers-$(make kernelversion)-hollywood-g$1_$(make kernelversion)-1_amd64.deb
sudo dpkg -i ../linux-image-$(make kernelversion)-hollywood-g$1_$(make kernelversion)-1_amd64.deb
sudo cp /vagrant/grub /etc/default/grub
sudo update-grub
export GRUB_CONFIG=`sudo find /boot -name "grub.cfg"`
sudo grub-set-default $(grep 'menuentry ' $GRUB_CONFIG | nl -v 0 | grep "hollywood-g$1'" | cut -c 6)]
cd ..
sudo rm -rf *