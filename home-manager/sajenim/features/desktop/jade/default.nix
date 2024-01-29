{ inputs, pkgs, ... }:

{
  imports = [
    ./rofi
    ./picom.nix
  ];

  home.packages = with pkgs; [
    feh
    xmobar
    unstable.wezterm
  ];

  home.file = {
    ".local/share/fonts" = {
      recursive = true;
      source = "${inputs.self}/pkgs/patched-fonts";
    };
    ".xinitrc".source = ./xinitrc;
  };
  
  xdg.configFile = {
    wezterm = { source = ./wezterm/config; recursive = true; };
  };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = "${inputs.self}/pkgs/xmonad-config/src/xmonad.hs";
  };
}

