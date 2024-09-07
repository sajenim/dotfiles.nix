{
  inputs,
  outputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.sajenim = {
    isNormalUser = true;
    extraGroups = ["audio" "docker" "networkmanager" "wheel" "adbusers"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [
      "${inputs.self}/home-manager/sajenim/sajenim_sk.pub"
    ];
    hashedPassword = "$y$j9T$qIhW5qL9J9w.w6JWa.bGo/$oddG3HJyOZ1mwHzYnYPJ/MzN38oHEBEvPDc0sB3rAf9";
  };
  users.mutableUsers = false;

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      sajenim = import "${inputs.self}/home-manager/sajenim/${config.networking.hostName}.nix";
    };
    backupFileExtension = "bak";
  };

  fileSystems."/home/sajenim" = {
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = ["subvol=sajenim" "compress=zstd"];
  };
}
