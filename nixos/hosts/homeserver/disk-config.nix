
# https://github.com/nix-community/disko/tree/master/example

{ lib, ... }:
{
  disko.devices = {
    disk = {
      disk1 = {
        device = lib.mkDefault "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            esp = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      mirror1 = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
      mirror2 = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    # mdadm = {
    #   boot = {
    #     type = "mdadm";
    #     level = 1;
    #     metadata = "1.0";
    #     content = {
    #       type = "filesystem";
    #       format = "vfat";
    #       mountpoint = "/boot";
    #       mountOptions = [ "umask=0077" ];
    #     };
    #   };
    # };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          data = {
            size = "100%";
            lvm_type = "mirror";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/mnt/data";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
