config-hw:
	nixos-generate-config
	mkdir -p /mnt/etc
	cp /etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hardware-configuration.nix

host ?= x230
build:
	nix build .#nixosConfigurations.$(host).config.system.build.toplevel

install:
	nixos-install
