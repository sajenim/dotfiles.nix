{ ... }:

{
  virtualisation.oci-containers.containers = {
    # # Open-source software alternative to µTorrent
    qbittorrent = {
      autoStart = true;
      image = "ghcr.io/hotio/qbittorrent:release-4.6.0";
      ports = [
        "8080:8080/tcp"   # WebUI
        "32372:32372/tcp" # Transport protocol
      ];
      volumes = [
        # Seedbox
        "/srv/multimedia/torrents:/data/torrents:rw"
        "/srv/containers/qbittorrent:/config:rw"
      ];
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
        "admin"
      ];
      service = "qbittorrent";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    qbittorrent.loadBalancer.servers = [
      { url = "http://192.168.1.102:8080"; }
    ];
  };
}

