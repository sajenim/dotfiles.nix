{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    shadow = true;
    backend = "glx";
    settings = {
      corner-radius = 10;
      rounded-corners-exclude = [
        # "window_type = 'normal'"
        "window_type = 'dock'"
      ];
    };
  };
}
