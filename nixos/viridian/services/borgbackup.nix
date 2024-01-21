{ ... }:

{
  services.borgbackup.jobs = {
    multimedia = {
      paths = [
        "/var/lib/jellyfin"
        "/var/lib/jellyseerr"
        "/var/lib/sonarr"
        "/var/lib/radarr"
        "/var/lib/lidarr"
      ];
      encryption.mode = "none";
      repo = "/mnt/backup/multimedia/borg";
      compression = "auto,zstd";
      startAt = "daily";
    };

    torrents = {
      paths = [
        "/var/lib/qbittorrent"
      ];
      encryption.mode = "none";
      repo = "/mnt/backup/torrents/borg";
      compression = "auto,zstd";
      startAt = "daily";
    };

    minecraft = {
      paths = [
        "/var/lib/minecraft"
      ];
      encryption.mode = "none";
      repo = "/mnt/backup/minecraft/borg";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}

