{ ... }:

{
  # Gitea
  virtualisation.oci-containers.containers."gitea" = {
    autoStart = true;
    image = "gitea/gitea:latest";
    volumes = [
      "/srv/gitea:/data"
      "/etc/localtime:/etc/localtime:ro"
    ];
    ports = [
      "4000:3000"
      "2221:22"
    ];
  };
}
