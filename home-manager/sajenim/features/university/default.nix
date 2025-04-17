{pkgs, ...}: {
  home.packages = with pkgs; [
    logisim
    libreoffice
    obsidian
    x2goclient
    zoom-us
  ];
}
