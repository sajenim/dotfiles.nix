{inputs, ...}: {
  imports = [
    ./cava
    ./discord
    ./dunst
    ./mpv
    ./picom
    ./rofi
    ./thunar
    ./wezterm
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
}
