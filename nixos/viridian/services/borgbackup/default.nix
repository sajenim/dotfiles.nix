{config, ...}: {
  age.secrets.borgbackup = {
    rekeyFile = ./passphrase.age;
  };

  services.borgbackup.jobs."borgbase" = {
    paths = [
      # Shares
      "/srv/shares/sajenim"
      # Services
      "/srv/services/forgejo"
      "/srv/services/immich"
      "/srv/services/minecraft"
      "/srv/services/paperless-ngx"
      # Containers
      "/srv/containers/jellyfin"
      "/srv/containers/lidarr"
      "/srv/containers/prowlarr"
      "/srv/containers/qbittorrent"
      "/srv/containers/radarr"
      "/srv/containers/sonarr"
    ];

    repo = "o93k24r6@o93k24r6.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.traefik.path}";
    };
    environment.BORG_RSH = "ssh -i /etc/ssh/ssh_host_ed25519_key";
    compression = "auto,lzma";
    startAt = "daily";
  };
}
