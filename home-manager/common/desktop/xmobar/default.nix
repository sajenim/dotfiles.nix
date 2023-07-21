{ inputs, pkgs, ... }: 

{
  nixpkgs.overlays = [
    (final: prev: {
      xmobar = inputs.xmobar-config.packages.${pkgs.system}.xmobar-config;
    })
  ];

  home.pkgs = with pkgs; [
    xmobar
  ];
}
