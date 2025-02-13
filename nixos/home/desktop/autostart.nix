{ config, pkgs, lib, inputs, ... }:

let
  autostart = import ../../lib/autostart_pkg_map.nix;
in
{
  home.file = autostart lib [
      pkgs.nekoray
      pkgs.seafile-client
      pkgs.vesktop
      pkgs.evolution
  ];
}
