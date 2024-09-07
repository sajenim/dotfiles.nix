{...}: {
  services.traefik.dynamicConfigOptions.http.routers = {
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

    ender1 = {
      rule = "Host(`e1.kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "ender1";
    };
  };
}
