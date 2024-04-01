{ inputs, outputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../features/cli
    ../features/nvim
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  
  programs.home-manager.enable = true;

  home = {
    username = "sajenim";
    homeDirectory = "/home/sajenim";
    sessionVariables = {
      EDITOR = "nvim";
    };

    persistence."/persist/home/sajenim" = {
      directories = [
        ".backup"
        ".github"
        ".gnupg"
        ".ssh"

        ".local/bin"
        ".local/share/nix"
      ];
      files = [
        ".zsh_history"
        ".local/share/direnv"
      ];
      allowOther = true;
    };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "22.11";
}
