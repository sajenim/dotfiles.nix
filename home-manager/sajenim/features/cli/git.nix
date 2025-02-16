{...}: {
  programs.git = {
    enable = true;
    userName = "jasmine";
    userEmail = "its.jassy@pm.me";
    extraConfig = {
      init.defaultBranch = "master";
      commit.gpgsign = "true";
      user.signingkey = "8563E358D4E8040E";
    };
  };
}
