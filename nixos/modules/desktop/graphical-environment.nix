{ config, pkgs, inputs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:caps_toggle,grp_led:scroll";
  };

  # screen capture?
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.arcmenu
    gnomeExtensions.tray-icons-reloaded
  ];
  
}
