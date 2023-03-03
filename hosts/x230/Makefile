conf ?= ./luks-btrfs.nix
disko := nix run github:nix-community/disko --no-write-lock-file --extra-experimental-features nix-command --extra-experimental-features flakes
disk:
	$(info run as root: `sudo su`)
	$(disko) -- -m create $(conf)
	$(disko) -- -m mount $(conf)
	mount | grep btrfs

memory := 8192
_swapfile := /mnt/swap/swapfile
swap:
	# >= 6.1: btrfs filesystem mkswapfile $(_swapfile)
	# prior:
	truncate -s 0 $(_swapfile)
	chattr +C $(_swapfile)
	btrfs property set $(_swapfile) compression none
	dd if=/dev/zero of=$(_swapfile) bs=1M count=$(memory)
	chmod 0600 $(_swapfile)
	mkswap $(_swapfile)

hiberation:
	# >= 6.1: btrfs inspect-internal map-swapfile swapfile

mount_point_root := /mnt
config-hw:
	nixos-generate-config --root $(mount_point_root)

host ?= x230
build:
	nix build .#nixosConfigurations.$(host).config.system.build.toplevel

install:
	nixos-install

docs:
	open https://bmcgee.ie/posts/2022/12/setting-up-my-new-laptop-nix-style/
	open https://github.com/nix-community/disko/blob/master/example/btrfs-subvolumes.nix
	open https://nixos.wiki/wiki/Btrfs
	open https://btrfs.readthedocs.io/en/latest/Swapfile.html
