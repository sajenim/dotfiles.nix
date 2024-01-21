{ ... }:

{
  virtualisation.oci-containers.containers = {
    dashboard = {
      autoStart = true;
      image = "ghcr.io/ajnart/homarr:latest";
      ports = [
        "7575:7575/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/var/lib/homarr/configs:/app/data/configs:rw"
        "/var/lib/homarr/icons:/app/public/icons:rw"
        "/var/lib/homarr/data:/data:rw"
        # Docker Integration
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
      extraOptions = [
        "--network=host"
      ];
    };
  };

  environment.persistence."/persist" = {
    directories = [ 
      "/var/lib/homarr/configs"
      "/var/lib/homarr/icons"
      "/var/lib/homarr/data"
    ];
  };
}
