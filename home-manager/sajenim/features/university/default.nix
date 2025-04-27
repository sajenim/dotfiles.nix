{pkgs, ...}: {
  home.packages = with pkgs; [
    logisim
    libreoffice
    x2goclient
    zoom-us
  ];
}
