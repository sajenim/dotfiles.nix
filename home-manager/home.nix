# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # Programs
    ./programs/discocss.nix
    ./programs/git.nix
    ./programs/mangohud.nix
    ./programs/nvim.nix
    ./programs/zsh.nix
    # Services
    ./services/picom.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };
  
  # Enable home-manager
  programs.home-manager.enable = true;

  home = {
    username = "sajenim";
    homeDirectory = "/home/sajenim";

    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      discord
      hilbish
      spotify
      unstable.prismlauncher
    ];
  };

  # Setup user configuration
  xdg.configFile = {
    awesome =  { source = ../config/awesome;  recursive = true; };
    wezterm =  { source = ../config/wezterm;  recursive = true; };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
