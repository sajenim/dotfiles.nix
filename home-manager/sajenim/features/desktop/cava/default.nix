{...}: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      input.method = "pulse";
      smoothing.noise_reduction = 88;
      color = {
        background = "'#32302f'";
        foreground = "'#d4be98'";
      };
    };
  };
}
