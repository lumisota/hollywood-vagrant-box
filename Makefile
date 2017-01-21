# 'shell' is a GNU make function (so this won't work with BSD make, for example)

BOX := hollywood-$(shell git rev-parse $(shell git ls-remote --heads git://github.com/lumisota/tcp-hollywood-linux | cut -f1)).box

all: $(BOX)

hollywood-%.box:
	@echo "================================================================================"
	@echo "== Building $@"
	vagrant up
	vagrant ssh -c "sudo sh /vagrant/bin/tcph-install.sh $*"
	vagrant package --output $@
	vagrant destroy -f
	@echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

clean:
	vagrant destroy -f
	rm -f $(BOX)
