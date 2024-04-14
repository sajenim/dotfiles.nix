{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.override { withOpenASAR = true; };
    })
  ];

  home.packages = with pkgs; [
    discord
    betterdiscordctl
  ];

  home.file.".config/BetterDiscord/data/stable/custom.css" = {
    enable = true;
    source = ./config/custom.css;
  };

  home.file.".config/BetterDiscord/plugins/HideChannels.plugin.js" = {
    enable = true;
    source = ./plugins/HideChannels.plugin.js;
  };

  home.file.".config/BetterDiscord/plugins/RemoveBlockedUsers.plugin.js" = {
    enable = true;
    source = ./plugins/RemoveBlockedUsers.plugin.js;
  };

  home.persistence."/persist/home/sajenim".directories = [
    ".config/discord"
    ".config/BetterDiscord"
  ];
}
