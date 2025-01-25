{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc

    jq
    yq-go
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
