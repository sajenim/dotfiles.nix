{ inputs, outputs, lib, config, pkgs, ... }:

{
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = /etc/nixos/home-manager/jade/xmonad/xmonad-jsm/src/xmonad.hs;
  };
}

