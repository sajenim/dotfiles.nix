{ inputs, outputs, lib, config, pkgs, ... }:

{
  programs.discocss = {
    enable = true;
    discordAlias = false;
  };

  xdg.configFile = {
    discocss = { source = ../../config/discocss; recursive = true; };
  };
}
