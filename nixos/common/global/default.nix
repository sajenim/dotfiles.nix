{ inputs, outputs, ... }:

{
  imports = [
    ./age.nix
    ./env.nix
    ./nix.nix
    ./ssh.nix
  ];

  nixpkgs = {
    overlays = [
      # Overlays exported from other flakes
      inputs.agenix-rekey.overlays.default
      # Overlays our own flake exports
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  i18n.defaultLocale = "en_AU.UTF-8";
  time.timeZone = "Australia/Perth";

  networking.domain = "kanto.dev";

  hardware.enableRedistributableFirmware = true;
}
