{ inputs, pkgs, ... }:

{
  imports = [ ];

  nixpkgs.overlays = [
    (final: prev: {
      xmobar = inputs.xmobar-config.packages.${pkgs.system}.xmobar-config;
    })
  ];

  home.packages = with pkgs; [
    dmenu
    feh
    unstable.wezterm
    xmobar
  ];

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad/xmonad-config/src/xmonad.hs;
  };

  home.file.".xinitrc".source = ./xinitrc;

  xdg.configFile = {
    wezterm = { source = ./wezterm; recursive = true; };
  };
}
