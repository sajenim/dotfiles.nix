{pkgs, ...}: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop
    ./features/editors
    ./features/games
    ./features/printing
    ./features/university
  ];

  home = {
    packages = with pkgs; [
      # Graphics
      gimp
      # Hardware
      piper
      pulsemixer
      # Multimedia
      mpc-cli
      ncmpcpp
      # Browsers
      firefox
    ];
  };
}
