{ ... }:

{
  virtualisation.oci-containers.containers = {
    nextcloud-aio-mastercontainer = {
      autoStart = true;
      image = "nextcloud/all-in-one:20231220_153200-latest";
      ports = [
        "8484:8080/tcp" # AIO Interface
      ];
      volumes = [
        "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
      environment = {
        NEXTCLOUD_DATADIR = "/mnt/data/nextcloud";
        APACHE_PORT = "11000";
        APACHE_IP_BINDING = "0.0.0.0";
      };
    };
  };
}

