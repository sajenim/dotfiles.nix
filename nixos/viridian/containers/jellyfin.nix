{ ... }:
let
  port = "8096";
in
{
  virtualisation.oci-containers.containers = {
    # Volunteer-built media solution that puts you in control of your media
    jellyfin = {
      autoStart = true;
      image = "jellyfin/jellyfin:10.9.6";
      ports = [
        "${port}:8096/tcp" # HTTP traffic
        "8920:8920/tcp" # HTTPS traffic
        # "1900:1900/udp" # Service auto-discovery
        "7359:7359/udp" # Client auto-discovery
      ];
      volumes = [
        # Media library
        "/srv/multimedia/library:/media:ro"
        # Container data
        "/srv/containers/jellyfin/config:/config:rw"
        "/srv/containers/jellyfin/cache:/cache:rw"
      ];
      environment = {
        PUID = "1000";
        PGID = "100";
      };
      extraOptions = [
        "--group-add=303"
        "--device=/dev/dri/renderD128:/dev/dri/renderD128"
        "--network=media-stack"
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    jellyfin = {
     rule = "Host(`jellyfin.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "jellyfin";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    jellyfin.loadBalancer.servers = [
      { url = "http://127.0.0.1:${port}"; }
    ];
  };
}

