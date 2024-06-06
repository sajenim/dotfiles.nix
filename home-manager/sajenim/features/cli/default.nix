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
      hostname = "192.168.1.102";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 62841;
    };
  };
}
