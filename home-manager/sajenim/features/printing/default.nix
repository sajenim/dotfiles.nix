{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      blender
      freecad
      kicad
      openscad
      unstable.prusa-slicer
    ];
    persistence."/persist/home/sajenim" = {
      directories = [
        ".config/PrusaSlicer"
      ];
    };
  };
}
