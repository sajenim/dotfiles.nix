{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [ ];

  home.packages = with pkgs; [
    dmenu
    feh
    wezterm
    xmobar-jsm
  ];
  
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = /etc/nixos/home-manager/jade/xmonad-jsm/src/xmonad.hs;
  };
}

