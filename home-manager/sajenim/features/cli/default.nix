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
      hostname = "192.168.50.227";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 62841;
    };

    matchBlocks."lavender" = {
      hostname = "192.168.50.249";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 22;
    };
  };
}
