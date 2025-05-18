{...}: {
  services.picom = {
    enable = true;
    shadow = true;
    shadowExclude = [
      "class_g = 'dmenu'"
    ];
    backend = "xrender";
  };
}
