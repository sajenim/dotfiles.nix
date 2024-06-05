{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Movie collection manager for Usenet and BitTorrent users
    radarr = {
      autoStart = true;
      image = "ghcr.io/hotio/radarr:nightly-5.1.3.8237";
      ports = [
        "7878:7878/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/srv/multimedia:/data:rw"
        # Container data
        "/srv/containers/radarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
  services.traefik.dynamicConfigOptions.http.routers = {
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
  };

  services.traefik.dynamicConfigOptions.http.services = {
    radarr.loadBalancer.servers = [
      { url = "http://192.168.1.102:7878"; }
    ];
  };
}

