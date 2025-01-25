{ config, pkgs, inputs, username, ... }:

let
  secrets = import ../../secrets.nix;
in
{
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  users.users.root.hashedPassword = secrets.rootpasswd;

  users.users.root.openssh.authorizedKeys.keys = [ secrets.publickey ];
  users.users.${username}.openssh.authorizedKeys.keys = [ secrets.publickey ];
}
