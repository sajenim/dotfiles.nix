{ pkgs, ... }: 

{
  environment = {
    systemPackages = with pkgs; [
      # Ensure home-manager is on all systems
      home-manager

      # Useful system utilities
      tree    # directory structure
      bc      # basic calculator
      vim     # editor
      ranger  # console file manager
      htop    # system monitor
      scrot   # screenshot

      # HTTP
      curl    # transfer dato to/from server
      wget    # download files from web

      # Archive
      unrar   # extract roshal archive
      unzip   # extract zip archive
    ];
  };
}
