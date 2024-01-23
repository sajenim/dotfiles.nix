{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Volunteer-built media solution that puts you in control of your media
    jellyfin = {
      autoStart = true;
      image = "jellyfin/jellyfin:10.8.12";
      ports = [
        "8096:8096/tcp" # HTTP traffic
        "8920:8920/tcp" # HTTPS traffic
        # "1900:1900/udp" # Service auto-discovery
        "7359:7359/udp" # Client auto-discovery
      ];
      volumes = [
        # Media library
        "/srv/multimedia/library:/media:ro"
        # Container data
        "/srv/containers/jellyfin/config:/config:rw"
        "/srv/containers/jellyfin/cache:/cache:rw"
      ];
      extraOptions = [
        "--group-add=303"
        "--device=/dev/dri/renderD128:/dev/dri/renderD128"
        "--network=media-stack"
      ];
    };
  };
}
