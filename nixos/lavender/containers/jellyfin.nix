{ ... }:

{
  # Jellyfin
  virtualisation.oci-containers.containers."jellyfin" = {
    autoStart = true;
    image = "jellyfin/jellyfin";
    volumes = [
      "/srv/jellyfin/config:/config"
      "/srv/jellyfin/cache:/cache"
      "/srv/media:/media"
    ];
    ports = [ "8096:8096" ];
  };
}
