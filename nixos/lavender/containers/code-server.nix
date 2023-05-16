{ ... }:

{
  # Code server
  virtualisation.oci-containers.containers."code-server" = {
    autoStart = true;
    image = "lscr.io/linuxserver/code-server:latest";
    volumes = [
      "/srv/code-server:/config"
    ];
    ports = [ "8443:8443" ];
  };
}
