# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.impermanence.nixosModules.home-manager.impermanence

    # You can also split up your configuration and import pieces of it here:

    # User services
    ./services/picom

    # User programs
    ./programs/discord
    ./programs/mangohud
    ./programs/rofi

    # Common programs
    ../common/programs/git
    ../common/programs/zsh
    ../common/programs/nvim
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # inputs.neovim-nightly-overlay.overlays.default

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
  programs = {
    home-manager.enable = true;
    ssh = {
      enable = true;
      matchBlocks = {
        "viridian" = {
          hostname = "192.168.1.102";
        };
      };
    };
  };

  home = {
    # Setup our user environment
    username = "sajenim";
    homeDirectory = "/home/sajenim";
    sessionVariables = {
      EDITOR = "nvim";
    };
  
    # Install some packages
    packages = with pkgs; [
      # Stable user programs
      feh
      gamemode
      spotify
      prismlauncher
      runelite
      jellyfin-media-player
      xmobar
      # Unstable user programs
      unstable.wezterm
    ];

    persistence."/persist/home/sajenim" = {
      directories = [
        "Documents"
        "Downloads"
        "Games"
        "Music"
        "Pictures"
        "Printer"
        "Videos"

        ".gnupg"
        ".ssh"
        ".github"
        ".mozilla"
        ".zsh_history"

        ".local/bin"
        ".local/share/nix"
        ".local/share/nvim"

        ".config/discord"
        ".config/BetterDiscord"
        ".config/PrusaSlicer"
        ".config/Yubico"
      ];
      allowOther = true;
    };
  };

  # Setup our window manager
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ../../pkgs/xmonad-config/src/xmonad.hs;
  };

  # Copy our personal font collection 
  home.file.".local/share/fonts" = {
    recursive = true;
    source = ../common/fonts;
  };

  # Copy some configuration files to $XDG_CONFIG_HOME
  xdg.configFile = {
    wezterm = { source = ./programs/wezterm/config; recursive = true; };
  };
  
  # Setup our desktop environment
  home.file.".xinitrc".source = ./xinitrc;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
