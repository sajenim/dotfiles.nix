{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.override {withOpenASAR = true;};
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
}
