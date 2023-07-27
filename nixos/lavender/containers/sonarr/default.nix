{ ... }:

{
  # Sonarr
  virtualisation.oci-containers.containers."sonarr" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/sonarr:v4";
    volumes = [
      "/srv/containers/sonarr:/config"
      "/srv/data:/data"
    ];
    ports = [ "8989:8989" ];
  };
}
