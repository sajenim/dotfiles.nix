{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.wezterm.packages.${pkgs.system}.default
  ];

  xdg.configFile = {
    wezterm = {
      source = ./config;
      recursive = true;
    };
  };
}
