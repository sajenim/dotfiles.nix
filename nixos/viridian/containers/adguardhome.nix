{ ... }:
let
  port = "3000";
in
{
  virtualisation.oci-containers.containers = {
    adguardhome = {
      autoStart = true;
      image = "adguard/adguardhome:v0.107.51";
      ports = [
        "53:53"     # Plain DNS
        "${port}:3000" # WEBGUI
      ];
      volumes = [
        "/srv/containers/adguardhome/work:/opt/adguardhome/work"
        "/srv/containers/adguardhome/conf:/opt/adguardhome/conf"
      ];
      extraOptions = [
        "--network=host"
      ];
    };
  };
  services.traefik.dynamicConfigOptions.http.routers = {
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
  };

  services.traefik.dynamicConfigOptions.http.services = {
    adguard-home.loadBalancer.servers = [
      { url = "http://127.0.0.1:${port}"; }
    ];
  };
}

