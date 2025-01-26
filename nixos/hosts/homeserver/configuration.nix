{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
    ./hardware-configuration.nix

    ../../modules/common
    ../../modules/server

    ../../modules/services/nextcloud.nix
  ];

  networking.hostName = "homeserver";
}

