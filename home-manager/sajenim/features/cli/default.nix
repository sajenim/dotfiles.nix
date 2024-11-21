{...}: {
  imports = [
    ./git.nix
    ./nvim.nix
    ./zsh.nix
  ];

  programs.ssh = {
    enable = true;
    matchBlocks."viridian" = {
      hostname = "viridian.home.arpa";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 22;
    };

    matchBlocks."lavender" = {
      hostname = "lavender.home.arpa";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 22;
    };
  };
}
