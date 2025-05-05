{config, ...}: {
  age.secrets.borgbackup = {
    rekeyFile = ./passphrase.age;
  };

  services.borgbackup.jobs."borgbase" = {
    paths = [
      # Websites
      "/srv/www/sajenim.dev"
      # File shares
      "/srv/shares/sajenim"
      # Services
      "/var/lib/crowdsec"
      "/var/lib/forgejo"
      "/var/lib/jupyterhub"
      "/var/lib/minecraft"
      "/var/lib/traefik"
      # Multimedia
      "/srv/multimedia/containers/jellyfin"
      "/srv/multimedia/containers/lidarr"
      "/srv/multimedia/containers/prowlarr"
      "/srv/multimedia/containers/qbittorrent"
      "/srv/multimedia/containers/radarr"
      "/srv/multimedia/containers/sonarr"
    ];

    repo = "r7ag7x1w@r7ag7x1w.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.borgbackup.path}";
    };
    environment.BORG_RSH = "ssh -i /etc/ssh/ssh_host_ed25519_key";
    compression = "auto,lzma";
    startAt = "daily";
  };

  programs.ssh.knownHostsFiles = [
    ./borgbase_hosts
  ];
}
