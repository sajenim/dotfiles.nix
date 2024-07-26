{ pkgs, ... }:

{
  # Required to install flatpak
  xdg.portal = {
    enable = true;
    config.common.default = [ "gtk" ];
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  services.flatpak = {
    enable = true;
    onCalender = "weekly";
  };
}
