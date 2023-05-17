{ ... }:

{
  # Overseerr
  virtualisation.oci-containers.containers."overseerr" = {
    autoStart = true;
    image = "sctx/overseerr:latest";
    volumes = [
      "/srv/containers/overseerr:/app/config"
    ];
    ports = [ "5055:5055" ];
  };
}
