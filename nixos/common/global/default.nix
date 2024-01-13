{ outputs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./system-tools.nix
  ];

  nixpkgs = {
    overlays = [
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
