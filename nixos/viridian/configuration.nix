{...}: {
  imports = [
    # Global configuration for all our systems
    ../common/global
    # Our user configuration and optional user units
    ../common/users/sajenim
    ../common/users/spectre
    # Programs and services
    ./programs
    ./services
    ./containers
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
        53 # adguardhome (DNS)
        80 # traefik     (HTTP)
        443 # traefik     (HTTPS)
        32372 # qbittorrent
        6600 # mpd
      ];
      allowedUDPPorts = [
        53 # adguardhome (DNS)
        80 # traefik     (HTTP)
        443 # traefik     (HTTPS)
        32372 # qbittorrent
        6600 # mpd
      ];
    };
  };

  # Use docker instead of podman for our containers.
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  # Required for smooth remote deployments
  security.sudo.wheelNeedsPassword = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
