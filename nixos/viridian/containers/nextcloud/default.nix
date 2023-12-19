{ ... }:

{
  virtualisation.oci-containers.containers = {
    nextcloud-aio-mastercontainer = {
      autoStart = true;
      image = "nextcloud/all-in-one:latest";
      ports = [
        "8484:8080/tcp" # AIO Interface
      ];
      volumes = [
        "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
      environment = {
        NEXTCLOUD_DATADIR = "/srv/nextcloud";
        APACHE_PORT = "11000";
        APACHE_IP_BINDING = "0.0.0.0";
      };
    };
  };
}

