# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  xmobar = pkgs.callPackage ./xmobar-config { };
  xmonad = pkgs.callPackage ./xmonad-config { };
  jellyfin-rpc = pkgs.callPackage ./jellyfin-rpc { };
}
