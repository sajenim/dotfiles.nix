{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Our ephemeral system. Wipe root on reboot.
    ../common/optional/ephemeral-btrfs.nix
  ];

  # Boot configuration
  boot = {
    # Initial ramdisk
    initrd = {
      # The modules listed here are available in the initrd, but are only loaded on demand.
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      # List of modules that are always loaded by the initrd.
      kernelModules = ["kvm-amd" "amdgpu"];
    };

    # Linux kernel used by NixOS.
    kernelPackages = pkgs.unstable.linuxPackages;
    # Parameters added to the kernel command line.
    kernelParams = [
      # Enable amdgpu driver sysfs API that allows fine grain control of GPU
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    # The set of kernel modules to be loaded in the second stage of the boot process.
    kernelModules = ["i2c-dev" "i2c-piix4"];

    # Our boot loader configuration
    loader = {
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
    };
  };

  # Hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };

  # Setup our filesystems
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024;
    }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
