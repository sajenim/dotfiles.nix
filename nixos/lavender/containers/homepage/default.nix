{ ... }:

{
  # Homepage
  virtualisation.oci-containers.containers."homepage" = {
    autoStart = true;
    image = "ghcr.io/benphelps/homepage:latest";
    volumes = [
      "/srv/containers/homepage:/app/config"
      "/srv/media:/srv/media:ro"
    ];
    ports = [ "3000:3000" ];
  };
}
