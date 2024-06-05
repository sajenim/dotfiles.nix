{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Request management
    jellyseerr = {
      autoStart = true;
      image = "ghcr.io/hotio/jellyseerr";
      ports = [
        "5055:5055/tcp" # WebUI
      ];
      volumes = [
        "/srv/containers/jellyseerr:/config"
      ];
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
      { url = "http://192.168.1.102:5055"; }
    ];
  };
}

