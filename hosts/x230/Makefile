conf ?= ./x230-luks-btrfs.nix
disko := nix run github:nix-community/disko --no-write-lock-file --extra-experimental-feature nix-command --extra-experimental-feature flakes
disk:
	sudo su
	$(info create the disk layout)
	$(disko) -- -m create $(conf)
	$(info mount the disk layout)
	$(disko) -- -m mount $(conf)
	mount | grep btrfs

memory := 8192
mount_point_swap := /mnt/swap
_swapfile := $(mount_point_swap)/swapfile
swap:
	# >= 6.1: btrfs filesystem mkswapfile $(swapfile)
	# prior:
	truncate -s 0 $(swapfile)
	chattr +C $(swapfile)
	btrfs property set $(swapfile) compression none
	dd if=/dev/zero of=$(swapfile) bs=1M count=$(memory)
	chmod 0600 $(swapfile)
	mkswap $(swapfile)

hiberation:
	# >= 6.1: btrfs inspect-internal map-swapfile swapfile

mount_point_root := /mnt
mount_point_boot := /mnt/boot
config-hw:
	nixos-generate-config --root $(mount_point_root)
	mkdir $(mount_point_boot)/efi

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
