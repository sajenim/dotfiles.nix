{
  pkgs,
  inputs,
  ...
}: {
  # Enable Visual Studio Code (VSCode) program
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = with pkgs.vscode-extensions; [
      sainnhe.gruvbox-material # Gruvbox Material theme
      github.copilot
      github.copilot-chat
    ];
    userSettings = {
      "window.menuBarVisibility" = "compact";
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Gruvbox Material Dark";
    };
  };

  # List of packages to be installed
  home.packages = with pkgs;
    [
      # Toolchain
      gcc
      unstable.python313Full # Note: keep this in sync with school.
    ]
    # Install jetbrains IDEs with plugins
    ++ (with inputs.nix-jetbrains-plugins.lib."${system}"; [
      (buildIdeWithPlugins pkgs.jetbrains "clion" [
        "gruvbox-material-dark"
      ])
      (buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" [
        "gruvbox-material-dark"
      ])
      (buildIdeWithPlugins pkgs.jetbrains "pycharm-professional" [
        "gruvbox-material-dark"
      ])
    ]);
    # https://github.com/theCapypara/nix-jetbrains-plugins
}
