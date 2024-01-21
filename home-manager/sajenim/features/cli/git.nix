{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

  programs.git = {
    enable = true;
    userName = "sajenim";
    userEmail = "its.jassy@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      core.sshCommand = "~/.ssh/sajenim_sk";
      user.signingkey = "~/.ssh/signing_sk";
    };
  };
}
