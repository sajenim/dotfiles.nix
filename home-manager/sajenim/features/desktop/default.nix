{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./cava
    ./dunst
    ./mpv
    ./picom
    ./rofi
    ./wezterm
  ];

  # Install some packages for our desktop environment
  home.packages = with pkgs; [
    firefox
    gimp
    piper
    zathura
  ];

  home.file = {
    # Install patched fonts
    ".local/share/fonts" = {
      recursive = true;
      source = "${inputs.self}/pkgs/patched-fonts";
    };
    # https://www.sainnhe.dev/post/patch-fonts-with-cursive-italic-styles/

    # Configure the initialization of xinit
    ".xinitrc".source = ./xinitrc;
  };

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
