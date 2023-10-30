{ ... }:

{
  # Jellyfin
  virtualisation.oci-containers.containers."jellyfin" = {
    autoStart = true;
    image = "jellyfin/jellyfin";
    volumes = [
      "/srv/containers/jellyfin/config:/config"
      "/srv/containers/jellyfin/cache:/cache"
      "/srv/data/media:/media"
    ];
    extraOptions = [
      "--group-add=303"
      "--device=/dev/dri/renderD128:/dev/dri/renderD128"
      "--network=host"
    ];
  };
}
