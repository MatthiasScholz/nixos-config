host ?= MacPro
pull:
	git pull

build:
	$(info Build Darwin Configuration)
	nix build ".#darwinConfigurations.$(host).system" --extra-experimental-features "nix-command flakes"

darwin-prepare:
	$(info Ensure folder exists in the system)
	printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
	/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t

darwin-rebuild:
	$(info Install Darwin Configuration in the system)
	./result/sw/bin/darwin-rebuild switch --flake .

setup-prerequistes:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

setup: build darwin-prepare darwin-rebuild
upgrade: pull build darwin-rebuild 