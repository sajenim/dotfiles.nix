{ ... }:

{
  services.borgbackup.jobs = {
    containers = {
      paths = [
        "/srv/containers"
      ];
      encryption.mode = "none";
      repo = "/srv/backup/borg/containers";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}

