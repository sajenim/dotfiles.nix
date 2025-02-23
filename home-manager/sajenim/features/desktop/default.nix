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
    inputs.xmonad-config.packages.${pkgs.system}.default
  ];

  home.file = {
    ".local/share/fonts" = {
      recursive = true;
      source = "${inputs.self}/pkgs/patched-fonts";
    };
    ".xinitrc".source = ./xinitrc;
  };
}
