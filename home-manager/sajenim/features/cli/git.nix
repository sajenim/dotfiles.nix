{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
  ];

  programs.git = {
    enable = true;
    userName = "jasmine";
    userEmail = "its.jassy@pm.me";
    extraConfig = {
      init.defaultBranch = "master";
      core.sshCommand = "ssh -i ~/.ssh/forgejo_sk -p 62841 -F /dev/null";
      commit.gpgsign = "true";
      user.signingkey = "8563E358D4E8040E";
    };
  };
}
