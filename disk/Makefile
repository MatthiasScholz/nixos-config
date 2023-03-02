conf ?= ./x230-luks-btrfs.nix
disko := nix run github:nix-community/disko --no-write-lock-file --extra-experimental-feature nix-command --extra-experimental-feature flakes
disk:
	$(info create the disk layout)
	$(disko) -- -m create $(conf)
	$(info mount the disk layout)
	$(disko) -- -m mount $(conf)
	mount | grep btrfs

docs:
	open https://bmcgee.ie/posts/2022/12/setting-up-my-new-laptop-nix-style/
	open https://github.com/nix-community/disko/blob/master/example/btrfs-subvolumes.nix
	open https://nixos.wiki/wiki/Btrfs
	open https://btrfs.readthedocs.io/en/latest/Swapfile.html
