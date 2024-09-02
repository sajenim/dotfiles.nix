{stdenv}: let
  lw5xl = ./lw5xl.ppd;
  raster2dymolw_v2 = ./raster2dymolw_v2;
in
  stdenv.mkDerivation rec {
    name = "lw5xw-${version}";
    version = "1.0";

    src = ./.;

    installPhase = ''
      mkdir -p $out/share/cups/model/
      cp ${lw5xl} $out/share/cups/model/

      mkdir -p $out/lib/cups/filter/
      cp ${raster2dymolw_v2} $out/lib/cups/filter/raster2dymolw_v2
    '';
  }
