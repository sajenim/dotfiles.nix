{ pkgs, ... }:

{
  # Enable necessary udev rules.
  services.udev.packages = with pkgs; [
    openrgb
    qmk-udev-rules
  ];
}
