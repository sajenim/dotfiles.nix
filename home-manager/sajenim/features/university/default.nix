{pkgs, ...}: {
  imports = [
    ./remarkable.nix
  ];

  home.packages = with pkgs; [
    logisim # required for outdated projects
    libreoffice
    obsidian
    x2goclient
    zathura
    zoom-us
  ];

  # Enable the use of the yubikey for ssh authentication
  programs.ssh = {
    matchBlocks = {
      "turing" = {
        hostname = "turing.une.edu.au";
        user = "jwils254";
        identityFile = "/home/sajenim/.ssh/jwils254_sk";
      };
    };
  };
}
