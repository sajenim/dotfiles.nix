{ ... }:
let
  port = "8487";
in
{
  virtualisation.oci-containers.containers = {
    # # Open-source software alternative to µTorrent
    qbittorrent = {
      autoStart = true;
      image = "ghcr.io/hotio/qbittorrent:release-4.6.5";
      ports = [
        "${port}:8080/tcp"   # WebUI
        "32372:32372/tcp" # Transport protocol
      ];
      volumes = [
        # Seedbox
        "/srv/multimedia/torrents:/data/torrents:rw"
        "/srv/containers/qbittorrent:/config:rw"
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
      rule = "Host(`torrent.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "qbittorrent";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    qbittorrent.loadBalancer.servers = [
      { url = "http://127.0.0.1:${port}"; }
    ];
  };
}

