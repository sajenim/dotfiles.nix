# This file defines overlays
{inputs, ...}: let
  raster2dymolw_v2 = ./raster2dymolw_v2;
in {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    cups-dymo = prev.cups-dymo.overrideAttrs (oldAttrs: {
      installPhase = ''
        installPhase
        cp ${raster2dymolw_v2} $out/lib/cups/filter/raster2dymolw_v2
      '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
