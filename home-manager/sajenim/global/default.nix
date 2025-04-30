{outputs, ...}: {
  imports = [
    ../features/cli/git.nix
    ../features/cli/ssh.nix
    ../features/cli/nvim.nix
    ../features/cli/zsh.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = false;
    };
  };

  programs.home-manager.enable = true;

  home = {
    username = "sajenim";
    homeDirectory = "/home/sajenim";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "22.11";
}
