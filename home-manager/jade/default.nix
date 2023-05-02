{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [ ];

  nixpkgs.overlays = [
    (final: prev: {
      xmonad-jsm = inputs.xmonad-jsm.packages.${pkgs.system}.xmonad-jsm;
      xmobar-jsm = inputs.xmobar-jsm.packages.${pkgs.system}.xmobar-jsm;
    })
  ];

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

