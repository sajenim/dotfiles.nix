{...}: {
  imports = [
    # Global configuration for all our systems
    ../common/global

    # Our user configuration and optional user units
    ../common/users/sajenim

    # Services
    ./services

    # Multimedia
    ./multimedia

    # Setup our hardware
    ./hardware-configuration.nix
  ];

  # Networking configuration
  networking = {
    hostName = "viridian";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        80
        443
        6600
      ];
    };
  };

  # Configure programs
  programs = {
    zsh.enable = true;
  };

  # Manage linux containers
  virtualisation = {
    docker = {
      enable = true;
      liveRestore = false;
    };
    # Implementation to use for containers
    oci-containers.backend = "docker";
  };

  # Required for smooth remote deployments
  security.sudo.wheelNeedsPassword = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
