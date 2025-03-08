{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./cava
    ./discord
    ./dunst
    ./gtk
    ./picom
    ./rofi
    ./wezterm
  ];

  home.packages = with pkgs; [
    feh
  ];

  home.file = {
    ".local/share/fonts" = {
      recursive = true;
      source = "${inputs.self}/pkgs/patched-fonts";
    };
    ".xinitrc".source = ./xinitrc;
  };
}
