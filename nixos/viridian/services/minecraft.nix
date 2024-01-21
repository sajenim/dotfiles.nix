{ pkgs, ... }:

{
  # Sandbox game developed by Mojang Studios
  services.minecraft-server = {
    enable = true;
    package = pkgs.unstable.minecraft-server;
    openFirewall = true;
    dataDir = "/var/lib/minecraft";
    declarative = true;
    serverProperties = {
      gamemode = "survival";
      level-name = "kanto.dev";
      difficulty = "easy";
      server-port = 25565;
      motd = "Welcome to our little private place!";
    };
    eula = true;
  };
  environment.persistence."/persist" = {
    directories = [ "/var/lib/minecraft" ];
  };
}

