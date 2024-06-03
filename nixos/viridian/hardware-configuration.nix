{ config, lib, ... }:
let
  hostname = config.networking.hostName;
in
{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "kvm-intel" ];
    };
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-label/ESP";
    fsType = "vfat";
  };

  fileSystems."/srv/multimedia" = { 
    device = "/dev/disk/by-label/multimedia";
    fsType = "ext4";
  };

  fileSystems."/srv/containers" = {
    device = "/dev/disk/by-label/${hostname}";
    fsType = "btrfs";
    options = [ "subvol=containers" "compress=zstd" ];
  };

  fileSystems."/srv/services" = {
    device = "/dev/disk/by-label/${hostname}";
    fsType = "btrfs";
    options = [ "subvol=services" "compress=zstd" ];
  };

  fileSystems."/srv/shares" = {
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = [ "subvol=shares" "compress=zstd" ];
  };

  fileSystems."/srv/backup" = {
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = [ "subvol=backup" "compress=zstd" ];
  };

  swapDevices = [ 
    { device = "/swap/swapfile";
      size = 16*1024;
    }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
