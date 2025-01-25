{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    htop
    sysstat
    lm_sensors # for `sensors` command
    wget
    curl

    file
    tree
    p7zip
    zip
    unzip

    ripgrep
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "mouse on";
    };
  };
}
