{ ... }:

{
  virtualisation.oci-containers.containers = {
    # Indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps.
    prowlarr = {
      autoStart = true;
      image = "ghcr.io/hotio/prowlarr:nightly-1.10.3.4070";
      ports = [
        "9696:9696/tcp" # WebUI
      ];
      volumes = [
        # Container data
        "/srv/containers/prowlarr:/config:rw"
      ];
      extraOptions = [
        "--network=media-stack"
      ];
    };
  };
}
