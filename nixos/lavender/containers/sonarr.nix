{ ... }:

{
  # Sonarr
  virtualisation.oci-containers.containers."sonarr" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/sonarr";
    volumes = [
      "/srv/sonarr/config:/config"
      "/srv/media:/media"
    ];
    ports = [ "8989:8989" ];
  };
}
