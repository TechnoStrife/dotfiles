{ config, pkgs, inputs, username, ... }:

let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/6eb01a67e1fc558644daed33eaeb937145e17696.tar.gz";
    sha256 = "sha256:16ri6b8fdvs93787ifamlvjx9g9yp556596srfn1k3p6p84dg5i6";
  }) {};
in
{
  services.seafile = {
    enable = true;

    adminEmail = "technostrife@gmail.com";
    initialAdminPassword = "change this later!";

    ccnetSettings.General.SERVICE_URL = "https://seafile.example.com";

    seahubPackage = pkgs.seahub;

    seafileSettings = {
      quota.default = "1500"; # Amount of GB allotted to users
      history.keep_days = "14"; # Remove deleted files after 14 days

      fileserver = {
        host = "unix:/run/seafile/server.sock";
        web_token_expire_time = 18000; # Expire the token in 5h to allow longer uploads
      };
    };

    # Enable weekly collection of freed blocks
    gc = {
      enable = true;
      dates = [ "Sun 03:00:00" ];
    };

    dataDir = "/mnt/data/seafile";
  };
}
