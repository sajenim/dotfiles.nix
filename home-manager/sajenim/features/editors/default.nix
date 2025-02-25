{pkgs, ...}: let
  # Define a function to add GitHub Copilot plugin to Jetbrains IDEs
  addGithubCopilot = ide: pkgs.jetbrains.plugins.addPlugins ide ["github-copilot"];
in {
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

    # Add GitHub Copilot plugin to Jetbrains IDEs
    (addGithubCopilot pkgs.jetbrains.clion)
    (addGithubCopilot pkgs.jetbrains.idea-ultimate)
    (addGithubCopilot pkgs.jetbrains.pycharm-professional)
  ];
}
