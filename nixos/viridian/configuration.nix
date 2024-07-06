{ pkgs, ... }: 

{
  imports = [
    ../common/global
    ../common/users/sajenim
    ../common/users/spectre

    ./services
    ./containers
    ./hardware-configuration.nix
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  networking = {
    hostName = "viridian";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        53    # adguardhome (DNS)
        80    # traefik     (HTTP)
        443   # traefik     (HTTPS)
        32372 # qbittorrent
        6600  # mpd
      ];
      allowedUDPPorts = [
        53    # adguardhome (DNS)
        80    # traefik     (HTTP)
        443   # traefik     (HTTPS)
        32372 # qbittorrent
        51820 # Wireguard
        6600  # mpd
      ];
    };
  };

 programs = {
    zsh.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  # Required for smooth remote deployments
  security.sudo.wheelNeedsPassword = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}

