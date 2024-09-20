{...}: {
  imports = [
    ./git.nix
    ./nvim.nix
    ./zsh.nix
  ];

  programs.ssh = {
    enable = true;
    matchBlocks."viridian" = {
      hostname = "viridian.kanto.dev";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 22;
    };

    matchBlocks."lavender" = {
      hostname = "lavender.kanto.dev";
      identityFile = "/home/sajenim/.ssh/sajenim_sk";
      port = 22;
    };
  };
}
