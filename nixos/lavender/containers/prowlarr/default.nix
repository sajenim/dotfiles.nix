{ ... }:

{
  # Prowlarr
  virtualisation.oci-containers.containers."prowlarr" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/prowlarr";
    volumes = [
      "/srv/containers/prowlarr:/config"
      "/srv/data:/data"
    ];
    ports = [ "9696:9696" ];
  };
}
