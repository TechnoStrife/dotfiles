
{ config, pkgs, inputs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "technostrife";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
