{ inputs, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager

    ../common/global
    ../common/users/sajenim

    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ 
      # Enable amdgpu driver sysfs API that allows fine grain control of GPU
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    initrd.kernelModules = [ "amdgpu" ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
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
    networkmanager.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      fantasque-sans-mono
      fira-code
      ibm-plex
      inconsolata
      iosevka
      jetbrains-mono
    ];
  };

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
      # Printing
      blender freecad openscad prusa-slicer
      # Misc
      openrgb protonup-ng
      # Hardware
      libratbag piper
    ];
    # Completions for system packages
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fuse.userAllowOther = true;    
  };

  services = {
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
          accelProfile = "flat";
        };
      };
      displayManager.startx.enable = true;
    };
    ratbagd.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
