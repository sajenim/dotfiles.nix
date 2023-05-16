{ ... }:

{
  # Radarr
  virtualisation.oci-containers.containers."radarr" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/radarr";
    volumes = [
      "/srv/radarr/config:/config"
      "/srv/media:/media"
    ];
    ports = [ "7878:7878" ];
  };
}
