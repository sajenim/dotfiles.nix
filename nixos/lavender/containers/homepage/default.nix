{ ... }:

{
  # Homepage
  virtualisation.oci-containers.containers."homepage" = {
    autoStart = true;
    image = "ghcr.io/benphelps/homepage:latest";
    volumes = [
      "/srv/containers/homepage:/app/config"
      "/srv/data:/srv/data:ro"
      "/var/run/docker.sock:/var/run/docker.sock" # pass local proxy
    ];
    extraOptions = ["--network=host"];
  };
}
