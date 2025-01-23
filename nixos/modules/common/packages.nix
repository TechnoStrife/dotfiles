{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    wget
    curl

    p7zip

    ripgrep
  ];
}
