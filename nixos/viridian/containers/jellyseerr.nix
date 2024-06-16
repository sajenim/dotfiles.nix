{ ... }:
let
  port = "5055";
in
{
  virtualisation.oci-containers.containers = {
    # Request management
    jellyseerr = {
      autoStart = true;
      image = "ghcr.io/hotio/jellyseerr:release-1.9.2";
      ports = [
        "${port}:5055/tcp" # WebUI
      ];
      volumes = [
        "/srv/containers/jellyseerr:/config"
      ];
      environment = {
        PUID = "1000";
        PGID = "100";
      };
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    jellyseerr = {
      rule = "Host(`jellyseerr.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "jellyseerr";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    jellyseerr.loadBalancer.servers = [
      { url = "http://127.0.0.1:${port}"; }
    ];
  };
}

