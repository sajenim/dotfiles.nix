{ ... }:

{
  # Nginx
  virtualisation.oci-containers.containers."nginx" = {
    autoStart = true;
    image = "nginx";
    volumes = [
      "/srv/containers/nginx:/usr/share/nginx/html"
    ];
    ports = [ "8282:80" ];
  };
}
