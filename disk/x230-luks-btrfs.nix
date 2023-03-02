{ disks ? [ "/dev/sda" ], ... }: {
  disk = {
    mx500 = {
      type = "disk";
      device = builtins.elemAt disks 0;
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "512MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              options = [
                "defaults"
              ];
            };
          }
          {
            type = "partition";
            name = "luks";
            start = "512MiB";
            end = "100%";
            content = {
              type = "luks";
              name = "crypted-root";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountpoint = "/";
                    mountOptions = [ "noatime" "compress=zstd"];
                  };
                  # Mountpoints inferred from subvolume name
                  "/home" = {
                    mountOptions = [ "noatime" "compress=zstd" ];
                  };
                  "/nix" = {
                    mountOptions = [ "noatime" "compress=zstd" ];
                  };
                  "/swap" = {
                    mountOptions = [ "noatime" "compress=none" ];
                  };
                };
              };
            };
          }
        ];
      };
    };
  };
}
