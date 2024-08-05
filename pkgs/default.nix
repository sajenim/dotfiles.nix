# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'

pkgs: {
  xmobar = pkgs.callPackage ./xmobar-config { };
  xmonad = pkgs.callPackage ./xmonad-config { };
  amdgpu-clocks = pkgs.callPackage ./amdgpu-clocks { };
}
