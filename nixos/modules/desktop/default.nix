{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot.nix
    ./splash-screen.nix
    ./network.nix
    ./graphical-environment.nix
    ./fonts.nix
    ./audio.nix
    ./programs.nix
    ./gaming.nix
    ./printing.nix
    ./vm.nix

    ./tailscale.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
