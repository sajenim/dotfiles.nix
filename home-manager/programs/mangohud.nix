{ inputs, outputs, lib, config, pkgs, ... }:

{
  programs.mangohud = {
    enable = true;
    settings = {
      gpu_temp = true;
      gpu_core_clock = true;
      cpu_temp = true;
      cpu_mhz = true;
    };
  };
}
