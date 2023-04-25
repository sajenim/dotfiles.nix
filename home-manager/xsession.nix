{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ./services/picom.nix
  ];

  home.packages = with pkgs; [
    dmenu
    feh
    wezterm
    candybar
  ];

  xsession = {
    enable = true;
    scriptPath = ".xsession-hm";
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      # extraPackages = haskellPackages: with haskellPackages; [ ];
      config = ../config/xmonad/xmonad.hs;
    };
    initExtra = ''
      xrandr --output HDMI-A-0 --mode 1920x1080 --output DisplayPort-0 --mode 2560x1440 --right-of HDMI-A-0
      feh --bg-scale ~/dotfiles.nix/assets/chinatown.png
    '';
  };

  xdg.configFile = {
    wezterm = { source = ../config/wezterm; recursive = true; };
  };
}
