{ config, pkgs, pkgs-stable, inputs, username, ... }:

{
  services.nginx.enable = true;
  networking.firewall.enable = false;

  services.nginx.virtualHosts."homeserver.tail817eb7.ts.net" = {
    sslCertificate = "/etc/ssl/certs/tailscale.crt";
    sslCertificateKey = "/etc/ssl/private/tailscale.key";
    forceSSL = true;
    # enableACME = true;
    locations = {
      "/" = {
        proxyPass = "http://unix:/run/seahub/gunicorn.sock";
        extraConfig = ''
          proxy_set_header   Host $host;
          proxy_set_header   X-Real-IP $remote_addr;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header   X-Forwarded-Host $server_name;
          proxy_read_timeout  1200s;
          client_max_body_size 0;
        '';
      };
      "/seafhttp" = {
        proxyPass = "http://unix:/run/seafile/server.sock";
        extraConfig = ''
          rewrite ^/seafhttp(.*)$ $1 break;
          client_max_body_size 0;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_connect_timeout  36000s;
          proxy_read_timeout  36000s;
          proxy_send_timeout  36000s;
          send_timeout  36000s;
        '';
      };
    };
  };

  services.seafile = {
    enable = true;

    adminEmail = "technostrife@gmail.com";
    initialAdminPassword = "change this later!";

    ccnetSettings.General.SERVICE_URL = "https://homeserver.tail817eb7.ts.net";

    seahubPackage = pkgs-stable.seahub;
    seahubAddress = "unix:/run/seahub/gunicorn.sock";

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
