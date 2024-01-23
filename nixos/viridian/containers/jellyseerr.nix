{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Request management
    jellyseerr = {
      autoStart = true;
      image = "ghcr.io/hotio/jellyseerr";
      ports = [
        "5055:5055/tcp" # WebUI
      ];
      volumes = [
        "/srv/containers/jellyseerr:/config"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
}
