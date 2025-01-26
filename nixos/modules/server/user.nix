
{ config, pkgs, inputs, username, ... }:

{
  users.users.guest = {
    isNormalUser = true;
    description = "guest";
  };
}
