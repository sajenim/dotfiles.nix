{ ... }:

{
  imports = [
    ./amdgpu-clocks.nix
    ./flatpak.nix
    ./ollama.nix
    ./udev.nix
    ./xserver.nix
  ];
}
