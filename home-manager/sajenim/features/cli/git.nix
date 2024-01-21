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
      core.sshCommand = "~/.ssh/github_sk.pub";
      user.signingkey = "~/.ssh/signing_sk.pub";
    };
  };
}
