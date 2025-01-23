{
  modulesPath,
  lib,
  pkgs,
  ...
}:
let
  secrets = import ../../secrets.nix;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "homeserver"; # Define your hostname.
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.

    # wpa_passphrase SSID PSK
    networks = {
      ${secrets.wifissid} = {
        pskRaw = secrets.wifipsk;
      };
    };
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.wget
    pkgs.gitMinimal
    pkgs.busybox
    pkgs.go
    pkgs.gcc
    pkgs.rustup
    pkgs.neofetch
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  users.users.root.hashedPassword = secrets.rootpasswd;

  users.users.root.openssh.authorizedKeys.keys = [ secrets.publickey ];

  system.stateVersion = "24.11";
}

