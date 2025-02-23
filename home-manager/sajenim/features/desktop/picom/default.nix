{...}: {
  services.picom = {
    enable = true;
    shadow = true;
    backend = "xrender";
  };
}
