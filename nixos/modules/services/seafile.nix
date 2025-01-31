{ config, pkgs, pkgs-stable, inputs, username, ... }:

{
  services.seafile = {
    enable = true;

    adminEmail = "technostrife@gmail.com";
    initialAdminPassword = "change this later!";

    ccnetSettings.General.SERVICE_URL = "https://seafile.example.com";

    seahubPackage = pkgs-stable.seahub;

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
