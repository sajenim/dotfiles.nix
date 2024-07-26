{ pkgs, ... }:

{
  imports = [
    ../common/global

    ../common/users/sajenim
    ../common/users/sajenim/samba
    ../common/users/sajenim/steam

    ../common/optional/key.nix

    ./programs
    ./services
    ./hardware-configuration.nix
  ];

  /* Boot configuration */
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ 
      # Enable amdgpu driver sysfs API that allows fine grain control of GPU
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    initrd.kernelModules = [ "amdgpu" ];
  };

  /* Hardware configuration */
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

  /* Networking configuration */
  networking = {
    hostName = "fuchsia";
    networkmanager.enable = true;
  };

  # Use docker instead of podman for our containers.
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
