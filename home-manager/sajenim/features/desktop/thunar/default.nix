{pkgs, ...}: {
  home.packages = with pkgs; [
    xfce.thunar
    xfce.ristretto
  ];
}
