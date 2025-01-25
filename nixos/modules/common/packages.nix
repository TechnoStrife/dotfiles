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

    ripgrep
  ];
}
