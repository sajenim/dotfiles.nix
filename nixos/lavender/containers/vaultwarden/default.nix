{ ... }:

{
  # Vaultwarden
  virtualisation.oci-containers.containers."vaultwarden" = {
    autoStart = true;
    image = "vaultwarden/server:latest";
    volumes = [
      "/srv/containers/vaultwarden:/data"
    ];
    ports = [ "8484:80" ];
    environment = {
      DOMAIN = "https://vault.kanto.dev";
    };
  };
}
