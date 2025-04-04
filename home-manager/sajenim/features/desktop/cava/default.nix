{...}: {
  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      input.method = "pulse";
      smoothing.noise_reduction = 88;
      color = {
        background = "'#282828'";
        foreground = "'#d4be98'";
      };
    };
  };
}
