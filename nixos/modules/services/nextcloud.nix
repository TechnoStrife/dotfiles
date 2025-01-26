{ config, pkgs, inputs, ... }:

let
  secrets = import ../../secrets.nix;
in
{
  environment.etc."nextcloud-admin-pass".text = secrets.nextcloudpass;
  services.nextcloud = {
    enable = true;

    # Need to manually increment with every major upgrade.
    package = pkgs.nextcloud30;
    
    # Let NixOS install and configure Redis caching automatically.
    configureRedis = true;

    datadir = "/mnt/nextcloud";
    
    hostName = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    
    # Increase the maximum file upload size to avoid problems uploading videos.
    maxUploadSize = "16G";
    
    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      # List of apps we want to install and are already packaged in
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
      inherit notes onlyoffice tasks cookbook;
    };
  };
}
