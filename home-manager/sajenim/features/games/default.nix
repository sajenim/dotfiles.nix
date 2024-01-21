{ pkgs, ... }:

{
  imports = [
    ./mangohud.nix
  ];

  home = {
    packages = with pkgs; [
      gamemode
      protonup-ng
      prismlauncher
      runelite
    ];
    persistence."/persist/home/sajenim" = {
      directories = [
        ".runelite"
      ];
    };
  };
}
