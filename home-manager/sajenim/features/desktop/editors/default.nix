{pkgs, ...}: {
  # Enable Visual Studio Code (VSCode) program
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      sainnhe.gruvbox-material # Gruvbox Material theme
    ];
  };

  # List of packages to be installed as part of the home configuration
  home.packages = [
    pkgs.gcc # GCC compiler
    pkgs.python39 # Python 3.9 interpreter

    # Jetbrains IDE's with GitHub Copilot plugin enabled
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion [
      "github-copilot"
    ])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate [
      "github-copilot"
    ])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-professional [
      "github-copilot"
    ])
  ];
}
