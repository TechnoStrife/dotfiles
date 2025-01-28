{ config, pkgs, inputs, username, ... }:

{
  home.packages = with pkgs; [
    evolution # email client
    hydroxide # protonmail bridge
  ];

  systemd.user.services.hydroxide = {
    Unit = {
      Description = "hydroxide protonmail bridge";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "/etc/profiles/per-user/${username}/bin/hydroxide -disable-carddav serve";
      Environment = [
        "NO_PROXY=localhost,127.0.0.0/8,::1"
        "FTP_PROXY=http://127.0.0.1:2080"
        "HTTPS_PROXY=http://127.0.0.1:2080"
        "HTTP_PROXY=http://127.0.0.1:2080"
        "ALL_PROXY=socks://127.0.0.1:2080"
      ];
    };
  };
}
