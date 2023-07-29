{ ... }:

{
  # Traefik
  virtualisation.oci-containers.containers."traefik" = {
    autoStart = true;
    image = "traefik:v2.10";
    volumes = [
      "/srv/containers/traefik/traefik.yaml:/etc/traefik/traefik.yaml"
      "/srv/containers/traefik/config:/config"
      "/srv/containers/traefik/letsencrypt:/letsencrypt"
      "/srv/containers/traefik/secrets:/secrets"
    ];
    ports = [
      "80:80"
      "443:443"
      "8080:8080"
    ];
    environment = {
      CF_API_EMAIL_FILE = "/secrets/cf-api-email";
      CF_API_KEY_FILE = "/secrets/cf-api-key";
    };
    extraOptions = ["--network=host"];
  };
}
