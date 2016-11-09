# 'shell' is a GNU make function (so this won't work with BSD make)

BOX := hollywood-$(shell git rev-parse --short $(shell git ls-remote --heads git://github.com/lumisota/tcp-hollywood-linux | cut -f1)).box

all: $(BOX)

%.box:
	vagrant up
	vagrant package --output $<
	vagrant destroy -f

clean:
	rm -f $(BOX)
