{pkgs, ...}: {
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];
    systemPackages = with pkgs; [
      # Ensure home-manager is on all systems
      home-manager

      # Useful system utilities
      tree # directory structure
      bc # basic calculator
      vim # editor
      ranger # console file manager
      htop # system monitor
      scrot # screenshot
      direnv # load environment
      jq # JSON processor
      git # version control
      nmap # network mapper
      xclip # clipboard
      ripgrep # searches the current directory for a regex pattern
      sshfs # Mount filesystems over SSH

      # HTTP
      curl # transfer dato to/from server
      wget # download files from web

      # Archive
      unrar # extract roshal archive
      unzip # extract zip archive
      p7zip # extract 7z archive
    ];
    pathsToLink = ["/share/zsh"];
  };
}
