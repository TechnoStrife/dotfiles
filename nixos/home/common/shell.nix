{ config, pkgs, inputs, ... }:

{
  programs.bash = {
    enable = true;
    # enable session variables
    initExtra = ''
      . "/etc/profiles/per-user/tech/etc/profile.d/hm-session-vars.sh"
    '';
  };

}
