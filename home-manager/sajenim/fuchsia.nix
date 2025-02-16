{pkgs, ...}: {
  imports = [
    ./global
    ./features/desktop
    ./features/printing
    ./features/games
  ];

  home = {
    packages = with pkgs; [
      # Graphics
      gimp
      inkscape
      krita
      # Hardware
      libratbag
      piper
      pulsemixer
      # Media
      mpc-cli
      ncmpcpp
      jellyfin-media-player
      # Misc
      firefox
      ledger-live-desktop
    ];
  };
}
