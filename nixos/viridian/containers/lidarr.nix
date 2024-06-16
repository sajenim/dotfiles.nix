{ ... }:
let
  port = "8686";
in
{
  virtualisation.oci-containers.containers = {
    # # Music collection manager for Usenet and BitTorrent users
    lidarr = {
      autoStart = true;
      image = "ghcr.io/hotio/lidarr:release-2.3.3.4204";
      ports = [
        "${port}:8686/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/srv/multimedia:/data:rw"
        # Container data
        "/srv/containers/lidarr:/config:rw"
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
    lidarr = {
      rule = "Host(`lidarr.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "admin"
      ];
      service = "lidarr";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    lidarr.loadBalancer.servers = [
      { url = "http://127.0.0.1:${port}"; }
    ];
  };
}

