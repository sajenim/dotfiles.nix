{ ... }:

{
  # Qbittorrent
  virtualisation.oci-containers.containers."qbittorrent" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/qbittorrent:release";
    volumes = [
      "/srv/containers/qbittorrent:/config"
      "/srv/data/torrents:/data/torrents"
    ];
    ports = [ 
      "8383:8080"
      "32372:32372"
    ];
  };
}
