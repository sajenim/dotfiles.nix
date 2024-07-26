{ pkgs, ... }:

{
  imports = [
    ./mangohud.nix
    ./runescape.nix
  ];

  home = {
    packages = with pkgs; [
      gamemode
      protonup-ng
      prismlauncher
    ];
  };
}
