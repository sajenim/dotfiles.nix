{
  pkgs,
  inputs,
  ...
}: {
  # Unfortunately some of these cannot be managed by
  # home-manager, so we must install them to the system.

  environment = {
    systemPackages = [
      # Required for some XFCE/GTK stuff
      pkgs.dconf
      # Picture viewer
      pkgs.xfce.ristretto
      # Install our XMonad and Xmobar configuration
      inputs.xmonad-config.packages.${pkgs.system}.default
    ];
  };

  programs = {
    # File browser
    thunar.enable = true;
    # Configuration storage system for xfce
    xfconf.enable = true;
  };

  services = {
    # Mount, trash, and other functionalities
    gvfs.enable = true;
    # Thumbnail support for images
    tumbler.enable = true;
  };
}
