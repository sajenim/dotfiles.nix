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
    ];
  };
}
