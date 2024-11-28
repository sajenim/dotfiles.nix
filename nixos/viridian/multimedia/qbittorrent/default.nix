{...}: let
  port = "8487";
in {
  virtualisation.oci-containers.containers = {
    # # Open-source software alternative to µTorrent
    qbittorrent = {
      autoStart = true;
      image = "ghcr.io/hotio/qbittorrent:release-5.0.2";
      ports = [
        "${port}:8080/tcp" # WebUI
        "32372:32372/tcp" # Transport protocol
      ];
      volumes = [
        # Seedbox
        "/srv/multimedia/torrents:/data/torrents:rw"
        "/srv/multimedia/containers/qbittorrent:/config:rw"
      ];
      environment = {
        PUID = "1000";
        PGID = "100";
      };
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    qbittorrent = {
      rule = "Host(`qbittorrent.home.arpa`)";
      entryPoints = [
        "websecure"
      ];
      service = "qbittorrent";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    qbittorrent.loadBalancer.servers = [
      {url = "http://127.0.0.1:${port}";}
    ];
  };
}
