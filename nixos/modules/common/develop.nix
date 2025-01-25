{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc

    jq
    yq
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
