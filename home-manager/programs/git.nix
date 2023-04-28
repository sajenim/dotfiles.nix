{ inputs, outputs, lib, config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "sajenim";
    userEmail = "its.jassy@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
