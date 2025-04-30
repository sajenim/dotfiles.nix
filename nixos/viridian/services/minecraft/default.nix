{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack rec {
    version = "7091175";
    url = "https://raw.githubusercontent.com/sajenim/minecraft-modpack/${version}/pack.toml";
    packHash = "sha256-9HZipG6/8GKnbXp0Qfug8Y2Db96hageUtprAuuuuGPM=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  services.minecraft-servers = {
    # Enable all of our servers
    enable = true;

    # Our minecraft servers
    servers = {
      kanto = {
        enable = true;
        # The minecraft server package to use.
        package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;}; # Specific fabric loader version.

        # Allowed players
        whitelist = {
          jasmariiie = "82fc15bb-6839-4430-b5e9-39c5294ff32f";
          Spectre_HWS = "491c085e-f0dc-44f1-9fdc-07c7cfcec8f2";
        };

        # JVM options for the minecraft server.
        jvmOpts = "-Xmx8G";

        # Minecraft server properties for the server.properties file.
        serverProperties = {
          gamemode = "survival";
          difficulty = "normal";
          motd = "\\u00A7aKanto Network \\u00A7e[1.19.2]\\u00A7r\\n\\u00A78I'll Use My Trusty Frying Pan As A Drying Pan!";
          server-port = 25565;
          white-list = true;
        };

        # Things to symlink into this server's data directory.
        symlinks = {
          "mods" = "${modpack}/mods";
        };

        # Things to copy into this server's data directory.
        files = {
          "ops.json" = ./ops.json;

          # Youre in grave danger
          "config/yigd.toml" = "${modpack}/config/yigd.toml";
        };

        # Value of systemd's `Restart=` service configuration option.
        restart = "no";
      };
    };

    # Each server will be under a subdirectory named after the server name.
    dataDir = "/var/lib/minecraft";

    # Open firewall for all servers.
    openFirewall = true;

    # https://account.mojang.com/documents/minecraft_eula
    eula = true;
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    minecraft = {
      rule = "Host(`minecraft.home.arpa`)";
      entryPoints = [
        "websecure"
      ];
      service = "minecraft";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    minecraft.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.minecraft-servers.servers.kanto.serverProperties.server-port}";}
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/minecraft";
        user = "minecraft";
        group = "minecraft";
      }
    ];
  };
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "minecraft-server"
  ];
}
