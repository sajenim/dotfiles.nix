{ ... }:

{
  # Minecraft
  virtualisation.oci-containers.containers."minecraft" = {
    image = "itzg/minecraft-server";
    ports = [
      "25565:25565"
    ];
    volumes = [
      "/srv/containers/minecraft:/data"
    ];
    environment = {
      EULA = "TRUE";
    };
    autoStart = true;
  };
}
