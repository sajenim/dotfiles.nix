{ ... }:

{
  # Radarr
  virtualisation.oci-containers.containers."radarr" = {
    autoStart = true;
    image = "cr.hotio.dev/hotio/radarr";
    volumes = [
      "/srv/containers/radarr:/config"
      "/srv/data:/data"
    ];
    ports = [ "7878:7878" ];
  };
}
