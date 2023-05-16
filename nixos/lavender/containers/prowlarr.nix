{ ... }:

{
  # Prowlarr
  virtualisation.oci-containers.containers."prowlarr" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/prowlarr";
    volumes = [
      "/srv/prowlarr/config:/config"
      "/srv/media:/media"
    ];
    ports = [ "9696:9696" ];
  };
}
