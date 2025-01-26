{ config, pkgs, inputs, ... }:

{
  imports = [
    ./files.nix
    ./git.nix
    ./home-manager.nix
    ./nvim.nix
    ./packages.nix
    ./shell.nix
    ./user.nix
    ./variables.nix
  ];
}
