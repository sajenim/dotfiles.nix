{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "Fisa Code 10";
    plugins = with pkgs; [
      rofi-calc
    ];
    theme = ./gruvbox-material/gruvbox-material-dark-hard.rasi;
  };

  xdg.configFile.theme = {
    source = ./gruvbox-material;
    target = "rofi/themes/gruvbox";
    recursive = true;
  };
}
