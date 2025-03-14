{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = [
      # Required for some XFCE/GTK stuff
      pkgs.dconf
      # Install our XMonad and Xmobar configuration
      inputs.xmonad-config.packages.${pkgs.system}.default
    ];
  };

  # Required dependencies for our xfce/gtk programs
  programs = {
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
