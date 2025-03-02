{pkgs, ...}: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop
    ./features/editors
    ./features/games
    ./features/printing
  ];

  home = {
    packages = with pkgs; [
      # Graphics
      gimp inkscape krita
      # Hardware
      libratbag piper pulsemixer
      # Media
      mpc-cli ncmpcpp jellyfin-media-player
      # Browsers
      firefox google-chrome
      # Remarkabl
      unstable.rmapi
      # University
      libreoffice obsidian x2goclient zoom-us
    ];
  };
}
