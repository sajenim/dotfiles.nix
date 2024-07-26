{ ... }:

{
  imports = [
    ./amdgpu-clocks.nix
    ./flatpak.nix
    ./libinput.nix
    ./ollama.nix
    ./udev.nix
    ./xserver.nix
  ];
}
