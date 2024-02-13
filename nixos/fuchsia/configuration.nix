{ pkgs, ... }:

{
  imports = [
    ../common/global
    ../common/users/sajenim
    ../common/optional/key.nix
    ../common/optional/steam.nix

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

  programs = {
    zsh.enable = true;
    direnv.enable = true;
    adb.enable = true;
  };

  services = {
    udev.packages = with pkgs; [
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
    pcscd.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
