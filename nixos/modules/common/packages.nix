{ config, pkgs, inputs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    htop
    sysstat
    lm_sensors # for `sensors` command
    wget
    xh
    curlie

    file
    tree
    p7zip
    zip
    unzip

    nh
    nix-output-monitor
    nvd

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

  environment.sessionVariables = {
    FLAKE = "/home/${username}/dotfiles/nixos";
  };
}
