{ lib, fetchFromGitHub, rustPlatform }:

with import <nixpkgs>
{
  overlays = [
    (import (fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
  ];
};
let
  rustPlatform = makeRustPlatform {
    cargo = rust-bin.stable.latest.minimal;
    rustc = rust-bin.stable.latest.minimal;
  };
in

rustPlatform.buildRustPackage rec {
  pname = "jellyfin-rpc";
  version = "0.15.5";

  src = fetchFromGitHub {
    owner = "Radiicall";
    repo = pname;
    rev = version;
    hash = "sha256-c4L/9ATxOGHv5bm3e2yforXR1ASvvopFc+J4XqQ5JKc=";
  };

  cargoHash = "sha256-RDP5fpLxKGYYbTUda2adL5y3CeuXV81uEo211KLKCfw=";

  doCheck = false;

  meta = with lib; {
    description = "Displays the content you're currently watching on Discord!";
    homepage = "https://github.com/Radiicall/jellyfin-rpc";
    license = with licenses; [ gpl3Only ];
    maintainers = with maintainers; [ sajenim ];
  };
}
