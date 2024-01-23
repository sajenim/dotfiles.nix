{ ... }:

{
  virtualisation.oci-containers.containers = {
    # PVR for Usenet and BitTorrent users
    sonarr = {
      autoStart = true;
      image = "ghcr.io/hotio/sonarr:nightly-4.0.0.710";
      ports = [
        "8989:8989/tcp" # WebUI
      ];
      volumes = [
        # Media library
        "/srv/multimedia:/data:rw"
        # Container data
        "/srv/containers/sonarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
}

