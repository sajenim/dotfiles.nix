{pkgs, ...}: {
  fileSystems."/home/sajenim/.local/share/Steam" = {
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = [
      "subvol=steam"
      "compress=zstd:3"
    ];
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.unstable.proton-ge-bin
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # When we mount our steam filesystem parent directories created are owned by root.
  # Lets fix that to avoid home-manager failing to start due to permission errors.
  systemd.tmpfiles.rules = [
    "d /home/sajenim/.local 0755 sajenim users -"
    "d /home/sajenim/.local/share 0755 sajenim users -"
  ];
}
