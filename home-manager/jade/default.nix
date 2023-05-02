{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [
    ./xmonad
  ];

  home.packages = with pkgs; [
    dmenu
    feh
    wezterm
  ];
  
  xdg.configFile = {
    wezterm = { source = ./wezterm; recursive = true; };
  };

  home.file.".xinitrc".source = ./xinitrc;
}

