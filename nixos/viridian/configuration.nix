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

    # Import services
    ./services/traefik
    ./services/media-stack

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

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

  networking = {
    hostName = "viridian";
    domain = "kanto.dev";
    networkmanager.enable = true;
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
      ];
    };
  };

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

    # Privacy protection center
    adguardhome = {
      enable = true;
      openFirewall = true;
      settings = {
        # Web interface IP address to listen on.
        bind_port = 3000;
        # Web interface IP port to listen on.
        bind_host = "0.0.0.0";
        # Custom DNS responses
        dns.rewrites = [
          { domain = "kanto.dev";
            answer = "192.168.1.102";
          }
          { domain = "*.kanto.dev";
            answer = "kanto.dev";
          }
        ];
      };
    };

    # Home automation that puts local control and privacy first.
    home-assistant = {
      enable = true;
      openFirewall = true;
      extraComponents = [
        # Components required to complete the onboarding
        "esphome"
        "met"
        "radio_browser"

        "adguard"
        "jellyfin"
      ];
      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/defaultoconfig/
        default_config = {};
        http = {
          use_x_forwarded_for = true;
          trusted_proxies = [
            "192.168.1.102"
          ];
        };
      };
      configDir = "/var/lib/home-assistant";
    };

    # Sandbox game developed by Mojang Studios
    minecraft-server = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/minecraft";
      declarative = true;
      serverProperties = {
        gamemode = "survival";
        level-name = "kanto";
        difficulty = "easy";
        server-port = 43000;
        motd = "A Caterpie May Change Into A Butterfree, But The Heart That Beats Inside Remains The Same.";
      };
      eula = true;
    };
  };

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users = {
    users = {
      # System administator
      sabrina = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "media" ];
        openssh.authorizedKeys.keyFiles = [
          ../../home-manager/erika/id_ed25519_sk.pub
        ];
        shell = pkgs.zsh;
      };
    };

    # Additional groups to create.
    groups = {
      media.members = [
        "jellyfin"
        "sonarr"
        "radarr"
        "lidarr"
        "qbittorrent"
      ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

