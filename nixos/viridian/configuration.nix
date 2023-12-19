# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
    outputs.nixosModules.qbittorrent

    # Or modules from other flakes (such as nixos-hardware):
    inputs.agenix.nixosModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import common configurations
    ../common/system-tools.nix

    # Import containers
    ./containers/dashboard
    ./containers/microbin
    ./containers/multimedia
    ./containers/nextcloud

    # Import services
    ./services/adguardhome
    ./services/home-assistant
    ./services/minecraft-server
    ./services/traefik

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  age.secrets.wireguard = {
    # Private key for wireguard
    file = inputs.self + /secrets/wireguard.age;
    owner = "root";
    group = "root";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      packageOverrides = pkgs: {
        # enable vaapi on OS-level
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
    };
  };

  nix = {
    gc = {
      # Automatically run the garbage collector an a specified time.
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # Select internationalisation properties
  i18n.defaultLocale = "en_AU.UTF-8";
  # Set timezone
  time.timeZone = "Australia/Perth";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernel.sysctl = {
      # Allow listening on TCP & UDP ports below 1024
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
    ];
  };

  networking = {
    hostName = "viridian";
    domain = "kanto.dev";
    networkmanager.enable = true;
    # Required for wireguard
    nat = {
      enable = true;
      externalInterface = "wlp2s0";
      internalInterfaces = [ "wg0" ];
    };
    # Setup our firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [
        53    # adguardhome (DNS)
        80    # traefik     (HTTP)
        443   # traefik     (HTTPS)
        32372 # qbittorrent
      ];
      allowedUDPPorts = [
        53    # adguardhome (DNS)
        80    # traefik     (HTTP)
        443   # traefik     (HTTPS)
        32372 # qbittorrent
        51820 # Wireguard
      ];
    };

    # Setup our Home network VPN
    wireguard.interfaces = {
      wg0 = {
        # IP address and subnet of the server's end of the tunnel interface
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o wlp2s0 -j MASQUERADE
       '';
        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o wlp2s0 -j MASQUERADE
        '';
        # Path to the private key file.
        privateKeyFile = config.age.secrets.wireguard.path;
        peers = [
          { # Pixel 6 Pro
            publicKey = "VaXMnFAXdbJCllNY5sIjPp9AcSM7ap2oA0tU9SIMK3E=";
            # List of IPs assigned to this peer within the tunnel subnet.
            allowedIPs = [ "10.100.0.2/32" ];
          }
          { # Samsung S23 Ultra
            publicKey = "dL91i7+VDWfeLCOr53JlzQ32WJ3lRJGqdecoqUpEnlQ=";
            allowedIPs = [ "10.100.0.3/32" ];
          }
        ];
      };
    };
  };

  # Setup environment
  environment = {
    # Symlink /bin/sh to POSIX-Complient shell
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ zsh ];

    # Install packages, prefix with 'unstable.' to use overlay
    systemPackages = with pkgs; [
      inputs.agenix.packages."${system}".default
    ];
  };
  programs = {
    zsh.enable = true;
  };

  services = {
    # This setups a SSH server. Very important if you're setting up a headless system.
    # Feel free to remove if you don't need it.
    openssh = {
      enable = true;
      # Forbid root login through SSH.
      settings.PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      settings.PasswordAuthentication = false;
    };
  };

  # Virtualisation
  virtualisation.docker.enable = true;

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users = {
    users = {
      # System administator
      sabrina = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "media" "docker" ];
        openssh.authorizedKeys.keyFiles = [
          ../../home-manager/sajenim/id_ed25519_sk.pub
        ];
        shell = pkgs.zsh;
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

