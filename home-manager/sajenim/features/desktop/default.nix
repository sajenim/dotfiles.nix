{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./discord
    ./dunst
    ./editors
    ./irc
    ./mpd
    ./picom
    ./rofi
    ./wezterm
  ];

  home.packages = with pkgs; [
    feh
    xmobar # custom build using xmobar-config
    xmonad # custom build using xmonad-config
  ];

  home.file = {
    ".local/share/fonts" = {
      recursive = true;
      source = "${inputs.self}/pkgs/patched-fonts";
    };
    ".xinitrc".source = ./xinitrc;
  };
}
