{ config, pkgs, inputs, stateVersion, ... }:

{
  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;
}
