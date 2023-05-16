{ ... }:

{
  # Qbittorrent
  virtualisation.oci-containers.containers."qbittorrent" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/qbittorrent";
    volumes = [
      "/srv/qbittorrent:/config"
      "/srv/media:/media"
    ];
    ports = [ "8080:8080" ];
  };
}
