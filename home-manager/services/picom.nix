{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    shadow = true;
    settings = {
      corner-radius = 5;
      rounded-corners-exclude = [
        "window_type = 'dock'"
      ];
    };
  };
}
