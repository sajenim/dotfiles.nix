{...}: {
  imports = [
    ./amdgpu-clocks.nix
    ./flatpak.nix
    ./libinput.nix
    ./udev.nix
    ./xserver.nix
  ];

  # Enable a few extra services.
  services = {
    pcscd.enable = true;
  };
}
