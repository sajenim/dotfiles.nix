{...}: let
  port = "7878";
in {
  virtualisation.oci-containers.containers = {
    # Movie collection manager for Usenet and BitTorrent users
    radarr = {
      autoStart = true;
      image = "ghcr.io/hotio/radarr:release-5.8.3.8933";
      ports = [
        "${port}:7878/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/srv/multimedia:/data:rw"
        # Container data
        "/srv/multimedia/containers/radarr:/config:rw"
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
    radarr = {
      rule = "Host(`radarr.home.arpa`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "radarr";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    radarr.loadBalancer.servers = [
      {url = "http://127.0.0.1:${port}";}
    ];
  };
}
