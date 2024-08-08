{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    wezterm
  ];

  xdg.configFile = {
    wezterm = {
      source = ./config;
      recursive = true;
    };
  };
}
