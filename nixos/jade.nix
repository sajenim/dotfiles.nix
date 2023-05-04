{ inputs, outputs, lib, config, pkgs, ... }:

{
  # Import our modules
  imports = [ ];
  
  # Add overlays exported from flakes:
  nixpkgs.overlays = [
    (final: prev: {
      xmonad-jsm = inputs.xmonad-jsm.packages.${pkgs.system}.xmonad-jsm;
      xmobar-jsm = inputs.xmobar-jsm.packages.${pkgs.system}.xmobar-jsm;
    })
  ];

  # Install our dependencies
  environment.systemPackages = with pkgs; [
    dmenu
    feh
    xmobar-jsm
  ];
 
  # Setup our window manager
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile "${inputs.xmonad-jsm}/src/xmonad.hs";
  };
}

