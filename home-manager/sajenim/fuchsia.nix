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
      pulsemixer
      # Media
      ncmpcpp
      jellyfin-media-player
      # Misc
      firefox
    ];

    persistence."/persist/home/sajenim" = {
      directories = [
        ".mozilla"
        # Mutable configurations
        ".config/Yubico"
        # Application specific data
        ".local/share/PrismLauncher"
        ".local/share/Jellyfin Media Player"
        # Our user data
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

