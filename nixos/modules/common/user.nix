
{ config, pkgs, inputs, username, ... }:

let
  secrets = import ../../secrets.nix;
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = "me";
    extraGroups = [ "networkmanager" "wheel" ];
    initialHashedPassword = secrets.userpasswd;
  };
}
