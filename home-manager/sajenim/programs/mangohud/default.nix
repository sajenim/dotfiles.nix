{ inputs, outputs, lib, config, pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    package = pkgs.unstable.mangohud;
    settings = {
      # GPU
      gpu_temp = true;
      gpu_junction_temp = true;
      gpu_core_clock = true;
      gpu_fan = true;
      gpu_voltage = true;

      # CPU
      cpu_temp = true;
      cpu_mhz = true;

      # FPS
      fps = true;
      frametime = false;
      frame_timing = false;

      # Miscellaneous
      wine = true;
      gamemode = true;

      # Hud dimensions
      table_columns = 4;
    };
  };
}
