
{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard # clipboard cli

    nekoray # proxy manager

    libreoffice-qt
    hunspell # spelling for libreoffice
    hunspellDicts.ru_RU
    hunspellDicts.en_US

    google-chrome

    obsidian

    flameshot # screenshots

    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
    vesktop # discord + vencord
  ];

  # Install firefox.
  programs.firefox.enable = true;
}
