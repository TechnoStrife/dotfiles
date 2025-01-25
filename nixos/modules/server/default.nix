{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot.nix
    ./network.nix
    ./ssh.nix
  ];
}

