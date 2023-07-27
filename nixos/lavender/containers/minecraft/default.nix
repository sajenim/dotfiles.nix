{ ... }:

{
  # Minecraft
  virtualisation.oci-containers.containers."minecraft" = {
    autoStart = true;
    image = "marctv/minecraft-papermc-server:latest";
    volumes = [
      "/srv/containers/minecraft:/data"
    ];
    ports = [ "25565:25565" ];
    environment = {
      MEMORYSIZE = "1G";
    };
  };
}
