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
      core.sshCommand = "ssh -i ~/.ssh/github_sk -F /dev/null";
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/signing_sk.pub";
    };
  };
}
