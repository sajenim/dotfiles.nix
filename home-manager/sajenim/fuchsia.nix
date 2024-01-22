{ pkgs, ... }:

{
  imports = [
    ./global

    ./features/desktop/common
    ./features/desktop/jade

    ./features/printing
    ./features/games
  ];

  home = {
    packages = with pkgs; [
      # Graphics
      gimp
      inkscape
      krita

      # Games
      gamemode
      protonup-ng
      prismlauncher
      runelite

      # Hardware
      libratbag
      piper

      # Misc
      spotify
      jellyfin-media-player
      firefox
      pulsemixer
    ];

    persistence."/persist/home/sajenim" = {
      directories = [
        ".mozilla"

        ".config/Yubico"

        "Documents"
        "Downloads"
        "Games"
        "Music"
        "Pictures"
        "Printer"
        "Videos"
      ];
    };
  };
}

