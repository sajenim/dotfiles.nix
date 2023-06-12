{ ... }:

{
  # Plex
  virtualisation.oci-containers.containers."plex" = {
    autoStart = true;
    image = "lscr.io/linuxserver/plex:latest";
    volumes = [
      "/srv/containers/plex:/config"
      "/srv/data/media:/data/media:ro"
    ];
    ports = [ "32400:32400" ];
    extraOptions = [ "--pull=newer" ];
  };
}
