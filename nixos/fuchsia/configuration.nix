{...}: {
  imports = [
    # Global configuartion for all our systems
    ../common/global
    # Our user configuration and optional user units
    ../common/users/sajenim
    ../common/users/sajenim/samba
    ../common/users/sajenim/steam
    # Optional components
    ../common/optional/key.nix
    # Programs and services
    ./programs
    ./services
    # Setup our hardware
    ./hardware-configuration.nix
  ];

  # Networking configuration
  networking = {
    hostName = "fuchsia";
    networkmanager.enable = true;
  };

  # Use docker instead of podman for our containers.
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
