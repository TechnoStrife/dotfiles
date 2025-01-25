
{ config, pkgs, inputs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "me";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
