{ config, pkgs, inputs, ... }:

{
  imports = [
    ../services/tailscale.nix
  ];
}
