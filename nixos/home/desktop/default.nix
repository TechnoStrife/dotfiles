{ config, pkgs, inputs, ... }:

{
  imports = [
    ./email.nix
    ./git.nix
  ];
}
