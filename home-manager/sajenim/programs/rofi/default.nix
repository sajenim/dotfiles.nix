{ inputs, outputs, lib, config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "Fira Code 10";
  };
}

