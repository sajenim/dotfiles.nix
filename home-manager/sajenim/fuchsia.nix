{pkgs, ...}: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop
    ./features/games
    ./features/printing
    ./features/university
  ];

  # Packages for our user environment
  home.packages = with pkgs; [
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

  # Configure GTK 2/3 applications to use gruvbox-material
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Material-Dark";
      package = pkgs.unstable.gruvbox-material-gtk-theme;
    };
    iconTheme.name = "Gruvbox-Material-Dark";
  };
}
