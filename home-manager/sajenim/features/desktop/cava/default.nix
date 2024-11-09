{...}: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      input.method = "pulse";
      smoothing.noise_reduction = 88;
      color = {
        background = "'#1d2021'";
        foreground = "'#d4be98'";
      };
    };
  };
}
