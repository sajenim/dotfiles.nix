{config, ...}: {
  age.secrets.borgbackup = {
    rekeyFile = ./passphrase.age;
  };

  services.borgbackup.jobs."borgbase" = {
    paths = [
      # Services
      "/srv/minecraft"
      "/srv/shares/sajenim"
      "/srv/www/sajenim.dev"
      "/var/lib/crowdsec"
      "/var/lib/forgejo"
      "/var/lib/immich"
      "/var/lib/paperless-ngx"
      "/var/lib/postgresql"
      "/var/lib/private/wiki-js"
      "/var/lib/redis-immich"
      "/var/lib/redis-paperless"
      "/var/lib/traefik"
      # Multimedia
      "/srv/multimedia/containers/jellyfin"
      "/srv/multimedia/containers/lidarr"
      "/srv/multimedia/containers/prowlarr"
      "/srv/multimedia/containers/qbittorrent"
      "/srv/multimedia/containers/radarr"
      "/srv/multimedia/containers/sonarr"
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
