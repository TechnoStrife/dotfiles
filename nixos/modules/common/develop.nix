
{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
