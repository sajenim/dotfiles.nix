{ ... }:

{
  virtualisation.oci-containers.containers = {
    # # Music collection manager for Usenet and BitTorrent users
    lidarr = {
      autoStart = true;
      image = "ghcr.io/hotio/lidarr:nightly-2.0.2.3782";
      ports = [
        "8686:8686/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/srv/multimedia:/data:rw"
        # Container data
        "/srv/containers/lidarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
}
