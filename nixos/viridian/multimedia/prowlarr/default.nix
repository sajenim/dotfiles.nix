{...}: let
  port = "9696";
in {
  virtualisation.oci-containers.containers = {
    # Indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps.
    prowlarr = {
      autoStart = true;
      image = "ghcr.io/hotio/prowlarr:release-1.26.1.4844";
      ports = [
        "${port}:9696/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/srv/multimedia/containers/prowlarr:/config:rw"
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
    prowlarr = {
      rule = "Host(`prowlarr.home.arpa`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "prowlarr";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    prowlarr.loadBalancer.servers = [
      {url = "http://127.0.0.1:${port}";}
    ];
  };
}
