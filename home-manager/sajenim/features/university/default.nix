{pkgs, ...}: {
  home.packages = with pkgs;
    [
      libreoffice
      obsidian
      x2goclient
      zoom-us
    ]
    ++ (with unstable.pkgs; [
      # Allows access to the ReMarkable Cloud API
      rmapi
      # Design and simulate digital logic circuits
      logisim-evolution
    ]);

  # Use our yubikey to login to university servers
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
