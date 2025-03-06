{
  pkgs,
  inputs,
  ...
}: {
  # Enable Visual Studio Code (VSCode) program
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      sainnhe.gruvbox-material # Gruvbox Material theme
    ];
  };

  # List of packages to be installed
  home.packages = with pkgs;
    [
      # Toolchain
      gcc
      jdk
      unstable.python313 # Note: keep this in sync with school.
    ]
    # Install jetbrains IDEs with plugins
    ++ (with inputs.nix-jetbrains-plugins.lib."${system}"; [
      (buildIdeWithPlugins pkgs.jetbrains "clion" [
        "com.github.copilot"
        "gruvbox-material-dark"
      ])
      (buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" [
        "com.github.copilot"
        "gruvbox-material-dark"
      ])
      (buildIdeWithPlugins pkgs.jetbrains "pycharm-professional" [
        "com.github.copilot"
        "gruvbox-material-dark"
      ])
    ]);
    # https://github.com/theCapypara/nix-jetbrains-plugins
}
