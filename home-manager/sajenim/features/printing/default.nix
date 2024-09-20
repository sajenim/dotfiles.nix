{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      unstable.blender
      freecad # https://discourse.nixos.org/t/error-hash-mismatch-in-fixed-output-derivation/52353
      unstable.kicad
      unstable.openscad
      prusa-slicer # Some error idk fix this later
    ];
  };
}
