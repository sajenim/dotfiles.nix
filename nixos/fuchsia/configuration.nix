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

    # Import common configurations
    ../common/system-tools.nix

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
  };
  
  # Select internationalisation properties
  i18n.defaultLocale = "en_AU.UTF-8";
  # Set timezone
  time.timeZone = "Australia/Perth";

  boot = {
    # Kernel to install
    kernelPackages = pkgs.linuxPackages_latest;
    # Parameters added to the kernel command line
    kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
    # Autoload stage 2 modules
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    # Autoload stage 1 modules
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      systemd-boot.enable = true;
    
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  hardware = {
    bluetooth.enable = true;
   
    # Setup sound server (Audio Support)
    pulseaudio = {
      enable = true;
      support32Bit = true; # If compatibility with 32-bit applications is desired.
    };
    
    # Configure OpenGL
    opengl = {
      enable = true;
      # Vulkan
      driSupport = true;
      driSupport32Bit = true;
      # OpenCL
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
  };

  networking = {
    hostName = "fuchsia";
    domain = "kanto.dev";
    networkmanager.enable = true;
    # firewall = {
    #   enable = true;
    #   allowedTCPPorts = [ ];
    #   allowedUDPPorts = [ ];
    # };
  };

  fonts = {
    # Install system fonts
    packages = with pkgs; [
      fantasque-sans-mono
      fira-code
      ibm-plex
      inconsolata
      iosevka
      jetbrains-mono
    ];
  };

  # Setup environment
  environment = {
    # Symlink /bin/sh to POSIX-Complient shell
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ zsh ];

    # Install packages, prefix with 'unstable.' to use overlay
    systemPackages = with pkgs; [
      # Audio
      pulsemixer

      # Code editors
      emacs vscode

      # Browsers
      firefox

      # Graphics
      gimp inkscape krita

      # Modelling
      blender freecad openscad cura

      # Misc
      openrgb protonup-ng

      # Hardware
      corectrl libratbag piper
    ];
    
    # Completions for system packages
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    zsh.enable = true;
    
    # GPG and SSH support for yubikey
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Dedicated Server
    };
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

    udev.packages = with pkgs; [
      yubikey-personalization
      openrgb
      qmk-udev-rules
    ];

    xserver = {
      enable = true;
      layout = "au";
      videoDrivers = [ "amdgpu" ];
      libinput = {
        enable = true;
        mouse = {
          # Disable mouse acceleration.
          accelProfile = "flat";
        };
      };
      displayManager.startx.enable = true;
    };

    ratbagd = {
      enable = true;
    };
  };

  # Install docker
  virtualisation.docker = {
    enable = true;
    # Reduce container downtime due to daemon crashes
    liveRestore = false;
  };

  # Login and use sudo with our yubikey
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # Users
  users.users.sajenim = {
      isNormalUser = true;
      extraGroups = [ "audio" "docker" "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = inputs.self + /home-manager/sabrina/id_ed25519.pub;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
