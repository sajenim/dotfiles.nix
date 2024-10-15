{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    settings = {
      port = 5432;
    };
    dataDir = "/var/lib/postgresql/15";
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/postgresql";
        user = "postgres";
        group = "postgres";
      }
    ];
  };
}
