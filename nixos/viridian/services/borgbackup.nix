{ ... }:

{
  services.borgbackup.jobs = {
    containers = {
      paths = [
        "/srv/containers"
      ];
      encryption.mode = "none";
      repo = "/srv/backup/containers";
      compression = "auto,zstd";
      startAt = "daily";
    };

    services = {
      paths = [
        "/srv/services"
      ];
      encryption.mode = "none";
      repo = "/srv/backup/services";
      compression = "auto,zstd";
      startAt = "daily";
    };

    shares = {
      paths = [
        "/srv/shares"
      ];
      encryption.mode = "none";
      repo = "/srv/backup/shares";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}

