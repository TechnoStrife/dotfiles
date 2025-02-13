{ config, pkgs, inputs, ... }:

{
  imports = [
    ./autostart.nix
    ./email.nix
    ./git.nix
  ];
}
