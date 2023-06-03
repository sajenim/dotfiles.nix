{ ... }:

{
  # Bitwarden
  virtualisation.oci-containers.containers."bitwarden" = {
    autoStart = true;
    image = "bitwarden/self-host:beta";
    volumes = [
      "/srv/containers/bitwarden:/etc/bitwarden"
    ];
    ports = [ "8484:8080" ];
    environmentFiles = [
      /etc/nixos/nixos/lavender/containers/bitwarden/settings.env
    ];
  };
}
