{ ... }:

{
  services.borgbackup.jobs = {
    containers = {
      paths = [
        "/srv/containers"
      ];
      encryption.mode = "none";
      repo = "/srv/backup/borg/containers";
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

