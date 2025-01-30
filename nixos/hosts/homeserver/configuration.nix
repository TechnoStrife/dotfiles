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
    ../../modules/services/tailscale.nix
  ];

  networking.hostName = "homeserver";
}

