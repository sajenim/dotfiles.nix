{ ... }:

{
  # Overseerr
  virtualisation.oci-containers.containers."overseerr" = {
    autoStart = true;
    image = "sctx/overseerr:latest";
    volumes = [
      "/srv/overseer:/app/config"
    ];
    ports = [ "5055:5055" ];
  };
}
