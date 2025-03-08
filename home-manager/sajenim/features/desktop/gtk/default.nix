{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Material-Dark";
      package = pkgs.unstable.gruvbox-material-gtk-theme;
    };
    iconTheme.name = "Gruvbox-Material-Dark";
  };

  home.packages = with pkgs; [
    xfce.thunar
    xfce.ristretto
  ];
}
