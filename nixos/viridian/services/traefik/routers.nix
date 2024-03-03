{ ... }:

{ 
  services.traefik.dynamicConfigOptions.http.routers = {
      entryPoints = [
        "websecure"
      ];
      middlewares = [
      ];
    };

    homarr = {
      rule = "Host(`kanto.dev`)";
      entryPoints = [ 
        "websecure"
      ];
      middlewares = [ 
        "admin"
      ];
      service = "homarr";
    };

    traefik-dashboard = {
      rule = "Host(`traefik.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "admin"
      ];
      service = "api@internal";
    };

    adguard-home = {
      rule = "Host(`adguard.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "admin"
      ];
      service = "adguard-home";
    };

    minecraft = {
      rule = "Host(`mc.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "minecraft";
    };

    jellyfin = {
     rule = "Host(`jf.kanto.dev`)";
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
        "admin"
      ];
      service = "sonarr";
    };

    radarr = {
      rule = "Host(`radarr.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "admin"
      ];
      service = "radarr";
    };

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

    prowlarr = {
      rule = "Host(`prowlarr.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "admin"
      ];
      service = "prowlarr";
    };

    qbittorrent = {
      rule = "Host(`qbittorrent.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "admin"
      ];
      service = "qbittorrent";
    };

    jellyseerr = {
      rule = "Host(`js.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "jellyseerr";
    };
  };
}

