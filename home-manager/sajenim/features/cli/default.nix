{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    lazygit
  ];

  programs.ssh = {
    enable = true;
    matchBlocks."viridian" = {
      hostname = "192.168.20.4";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 62841;
    };

    matchBlocks."lavender" = {
      hostname = "192.168.20.3";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 22;
    };
  };
}
