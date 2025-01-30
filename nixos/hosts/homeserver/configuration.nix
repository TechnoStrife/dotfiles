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

    ../../modules/services/tailscale.nix
    ../../modules/services/seafile.nix
  ];

  networking.hostName = "homeserver";
}

