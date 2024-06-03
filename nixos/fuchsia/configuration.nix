{ pkgs, ... }:

{
  imports = [
    ../common/global
    ../common/users/sajenim
    ../common/users/sajenim/samba
    ../common/users/sajenim/steam
    ../common/optional/key.nix

    ./services
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
      extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    };
    opengl = {
      enable = true;
      # Vulkan
      driSupport = true;
      driSupport32Bit = true;
      # OpenCL
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };

  networking = {
    hostName = "fuchsia";
    networkmanager.enable = true;
  };

  programs = {
    zsh.enable = true;
    direnv.enable = true;
    adb.enable = true;
  };

  services = {
    # Enable necessary udev rules.
    udev.packages = with pkgs; [
      openrgb
      qmk-udev-rules
    ];

    # Setup our display server.
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

    # Get up and running with large language models locally.
    ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
      acceleration = "rocm";
      # environmentVariables = {
      #  HSA_OVERRIDE_GFX_VERSION = "10.3.0";
      # };
    };

    # Enable a few other services.
    ratbagd.enable = true;
    pcscd.enable = true;
  };

  # Use docker instead of podman for our containers.
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
