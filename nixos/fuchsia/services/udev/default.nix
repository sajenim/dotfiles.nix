{pkgs, ...}: {
  # Enable necessary udev rules.
  services.udev.packages = with pkgs; [
    android-udev-rules
    openrgb
    qmk-udev-rules
  ];
}
