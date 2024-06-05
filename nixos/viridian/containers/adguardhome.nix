{ ... }:

{
  virtualisation.oci-containers.containers = {
    adguardhome = {
      autoStart = true;
      image = "adguard/adguardhome";
      ports = [
        "53:53"     # Plain DNS
        "3000:3000" # WEBGUI
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
      { url = "http://192.168.1.102:3000"; }
    ];
  };
}

