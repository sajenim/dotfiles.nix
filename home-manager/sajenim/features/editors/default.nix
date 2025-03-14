{pkgs, ...}: let
  # Plugin list to build our IDE's with
  buildIdeWithPlugins = ide:
    pkgs.jetbrains.plugins.addPlugins ide [
      "github-copilot" # patched to work with NixOS

      # Plugin ID: gruvbox-material-dark
      (pkgs.stdenv.mkDerivation {
        name = "gruvbox-material-dark";
        version = "1.0.2";
        src = pkgs.fetchurl {
          url = "https://downloads.marketplace.jetbrains.com/files/25641/650322/gruvbox-material-dark.jar";
          hash = "sha256-cgTJRisPqtZf5NMQqdbRhx1fbrx9U2eeHkpT8+rb+8E=";
        };
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out
          cp $src $out
        '';
      })
    ];
in {
  # Enable Visual Studio Code (VSCode) program
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = with pkgs.vscode-extensions; [
      sainnhe.gruvbox-material # Gruvbox Material theme
      github.copilot
      github.copilot-chat
    ];
    # Configuration
    userSettings = {
      "window.menuBarVisibility" = "compact";
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Gruvbox Material Dark";
    };
  };

  # List of packages to be installed
  home.packages = with pkgs; [
    # Toolchain
    gcc
    unstable.python313Full # Note: keep this in sync with school.

    # Install jetbrains IDE's with plugins
    (buildIdeWithPlugins pkgs.jetbrains.clion)
    (buildIdeWithPlugins pkgs.jetbrains.idea-ultimate)
    (buildIdeWithPlugins pkgs.jetbrains.pycharm-professional)
  ];
}
