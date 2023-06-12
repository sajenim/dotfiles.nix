{ ... }:

{
  # Recyclarr
  virtualisation.oci-containers.containers."recyclarr" = {
    autoStart = true;
    image = "ghcr.io/recyclarr/recyclarr:latest";
    volumes = [
      "/srv/containers/recyclarr:/config"
    ];
    extraOptions = [ "--pull=newer" ];
  };
}
