{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard # clipboard cli

    nekoray # proxy manager

    seafile-client

    libreoffice-qt
    hunspell # spelling for libreoffice
    hunspellDicts.ru_RU
    hunspellDicts.en_US

    google-chrome

    obsidian

    flameshot # screenshots

    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
    inputs.posting.packages.${pkgs.system}.posting
    vesktop # discord + vencord

    ffmpeg
    obs-studio
    mpv
    vlc
    qbittorrent
    quodlibet-full
  ];

  # Install firefox.
  programs.firefox.enable = true;
}
