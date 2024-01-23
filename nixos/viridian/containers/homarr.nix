{ ... }:

{
  virtualisation.oci-containers.containers = {
    homarr = {
      autoStart = true;
      image = "ghcr.io/ajnart/homarr:latest";
      ports = [
        "7575:7575/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/srv/containers/homarr/configs:/app/data/configs:rw"
        "/srv/containers/homarr/icons:/app/public/icons:rw"
        "/srv/containers/homarr/data:/data:rw"
        # Docker Integration
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
      extraOptions = [
        "--network=host"
      ];
    };
  };
}
