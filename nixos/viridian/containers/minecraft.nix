{ ... }:

{
  virtualisation.oci-containers.containers = {
    minecraft = {
      autoStart = true;
      image = "itzg/minecraft-server";
      ports = [
        "25565:25565"
      ];
      volumes = [
        "/srv/containers/minecraft:/data:rw"
      ];
      environment = {
        EULA = "true";
      };
    };
  };
}
