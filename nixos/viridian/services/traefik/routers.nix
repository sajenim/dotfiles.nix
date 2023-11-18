{ ... }:

{ 
  services.traefik.dynamicConfigOptions.http.routers = {
    httpd = {
      rule = "Host(`sajenim.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "geoblock"
      ];
      service = "httpd";
    };

    microbin = {
      rule = "Host(`bin.sajenim.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "geoblock"
      ];
      service = "microbin";
    };

    homarr = {
      rule = "Host(`kanto.dev`)";
      entryPoints = [ 
        "websecure"
      ];
      middlewares = [ 
        "internal"
      ];
      service = "homarr";
    };

    traefik-dashboard = {
      rule = "Host(`traefik.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "api@internal";
    };

    adguard-home = {
      rule = "Host(`adguard.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "adguard-home";
    };

    home-assistant = {
      rule = "Host(`home.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "home-assistant";
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
        "geoblock"
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

    jellyseerr = {
      rule ="Host(`jellyseerr.kanto.dev`)";
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

