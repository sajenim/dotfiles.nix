{ ... }:

{
  services.picom = {
    enable = true;
    shadow = true;
    backend = "glx";
    settings = {
      corner-radius = 10;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "class_g = 'Rofi'"
      ];
    };
  };
}
