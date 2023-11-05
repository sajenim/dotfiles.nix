{ ... }:

{ 
  services.traefik.dynamicConfigOptions = {
    http = {
      routers = {
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

        sonarr = {
          rule = "Host(`sonarr.kanto.dev`)";
          entryPoints = [
            "websecure"
          ];
          middlewares = [
            "internal"
          ];
          service = "sonarr";
        };

        radarr = {
          rule = "Host(`radarr.kanto.dev`)";
          entryPoints = [
            "websecure"
          ];
          middlewares = [
            "internal"
          ];
          service = "radarr";
        };

        lidarr = {
          rule = "Host(`lidarr.kanto.dev`)";
          entryPoints = [
            "websecure"
          ];
          middlewares = [
            "internal"
          ];
          service = "lidarr";
        };

        prowlarr = {
          rule = "Host(`prowlarr.kanto.dev`)";
          entryPoints = [
            "websecure"
          ];
          middlewares = [
            "internal"
          ];
          service = "prowlarr";
        };

        qbittorrent = {
          rule = "Host(`qbittorrent.kanto.dev`)";
          entryPoints = [
            "websecure"
          ];
          middlewares = [
            "internal"
          ];
          service = "qbittorrent";
        };
      };

      services = {
        jellyfin.loadBalancer.servers = [
          { url = "http://192.168.1.102:8096"; }
        ];
        sonarr.loadBalancer.servers = [
          { url = "http://192.168.1.102:8989"; }
        ];
        radarr.loadBalancer.servers = [
          { url = "http://192.168.1.102:7878"; }
        ];
        lidarr.loadBalancer.servers = [
          { url = "http://192.168.1.102:8686"; }
        ];
        prowlarr.loadBalancer.servers = [
          { url = "http://192.168.1.102:9696"; }
        ];
        qbittorrent.loadBalancer.servers = [
          { url = "http://192.168.1.102:8080"; }
        ];
      };
    };
  };
}
