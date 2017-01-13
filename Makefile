# 'shell' is a GNU make function (so this won't work with BSD make)

BOX := hollywood-$(shell git rev-parse --short $(shell git ls-remote --heads git://github.com/lumisota/tcp-hollywood-linux | cut -f1)).box

all: $(BOX)

hollywood-%.box:
	vagrant up
	vagrant ssh "sudo /vagrant/bin/tcph-install.sh $*"
	vagrant package --output $@
	vagrant destroy -f

clean:
	vagrant destroy -f
	rm -f $(BOX)
