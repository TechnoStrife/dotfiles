{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nixos.nix
    ./locale.nix
    ./user.nix
    ./packages.nix
    ./develop.nix
  ];
}
