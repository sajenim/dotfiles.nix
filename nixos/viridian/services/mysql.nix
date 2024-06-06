{ pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    dataDir = "/srv/services/mysql";
  };
}

