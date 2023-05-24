# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [ 
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    ./containers

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
      #Automatically run the garbage collector at a specific time.
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
   
    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store      
      auto-optimise-store = true;
    };

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  # Select internationalisation properties
  i18n.defaultLocale = "en_AU.UTF-8";
  # Set timezone
  time.timeZone = "Australia/Perth";

  boot = {
    # Kernel to install  
    kernelPackages = pkgs.linuxPackages_rpi4;    
    # ttyAMA0 is the serial console broken out to the GPIO
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      # A lot of GUI programs need this, nearly all wayland applications
      "cma=128M"
    ];

    loader = {
      # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
      grub.enable = false;
      # Enables the generation of /boot/extlinux/extlinux.conf
      generic-extlinux-compatible.enable = true;
    };

    # Mount a tmpfs on /tmp during boot
    tmpOnTmpfs = true;
  };

  hardware = {
    # Required for the Wireless firmware
    enableRedistributableFirmware = true;
  };
  
  networking = {
    hostName = "lavender";
    domain = "kanto.dev";
    networkmanager = {
      enable = true;
    };
  };
  
  environment = {
    systemPackages = with pkgs; [
      # System tools
      vim wget git home-manager tree ranger
    ];
    
    # Completions for system packages
    pathsToLink = [ "/share/zsh" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
 
  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ ../fuchsia/id_ed25519_sk.pub ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

