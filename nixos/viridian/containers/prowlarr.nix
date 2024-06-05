{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps.
    prowlarr = {
      autoStart = true;
      image = "ghcr.io/hotio/prowlarr:nightly-1.10.3.4070";
      ports = [
        "9696:9696/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/srv/containers/prowlarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
  services.traefik.dynamicConfigOptions.http.routers = {
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
  };
  
  services.traefik.dynamicConfigOptions.http.services = {
    prowlarr.loadBalancer.servers = [
      { url = "http://127.0.0.1:9696"; }
    ];
  };
}

