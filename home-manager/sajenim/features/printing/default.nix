{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      blender
      freecad
      kicad
      openscad
      prusa-slicer
    ];
  };
}
