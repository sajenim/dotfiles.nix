{ ... }:

{
  # Homepage
  virtualisation.oci-containers.containers."homepage" = {
    autoStart = true;
    image = "ghcr.io/benphelps/homepage:latest";
    volumes = [
      "/srv/containers/homepage:/app/config"
    ];
    ports = [ "3000:3000" ];
  };
}
