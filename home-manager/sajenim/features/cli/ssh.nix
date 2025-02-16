{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "viridian" = {
        hostname = "viridian.home.arpa";
        user = "sajenim";
        identityFile = "/home/sajenim/.ssh/sajenim_sk";
      };

      "lavender" = {
        hostname = "lavender.home.arpa";
        user = "sajenim";
        identityFile = "/home/sajenim/.ssh/sajenim_sk";
      };

      "sajenim-github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/sajenim/.ssh/sajenim-github_sk";
      };

      "jasmine-forgejo" = {
        hostname = "git.sajenim.dev";
        user = "forgejo";
        identityFile = "/home/sajenim/.ssh/jasmine-forgejo_sk";
      };
    };
  };
}
