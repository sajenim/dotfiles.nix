{ ... }:

{
  # Plex
  virtualisation.oci-containers.containers."plex" = {
    autoStart = true;
    image = "lscr.io/linuxserver/plex:latest";
    volumes = [
      "/srv/plex:/config"
      "/srv/media:/media"
    ];
    ports = [ "32400:32400" ];
  };
}
