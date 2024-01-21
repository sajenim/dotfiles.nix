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
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/signing_sk.pub";
    };
  };
}
