{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./discord
    ./rofi
    ./wezterm

    ./email.nix
    ./irc.nix
    ./mpd.nix
    ./picom.nix
  ];

  home.packages = with pkgs; [
    feh
    xmobar
    xmonad
  ];

  home.file = {
    ".local/share/fonts" = {
      recursive = true;
      source = "${inputs.self}/pkgs/patched-fonts";
    };
    ".xinitrc".source = ./xinitrc;
  };
}
