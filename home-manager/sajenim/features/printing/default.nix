{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      blender
      freecad
      openscad
      prusa-slicer
    ];
    persistence."/persist/home/sajenim" = {
      directories = [
        ".config/PrusaSlicer"
      ];
    };
  };
}
