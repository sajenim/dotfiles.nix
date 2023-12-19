{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.services.jellyfin-rpc;
  UID = 999;
  GID = 999;
in
{
  options.services.jellyfin-rpc = {
    enable = mkEnableOption "jellyfin-rpc service";

    user = mkOption {
      type = types.str;
      default = "jellyfin-rpc";
      description = lib.mdDoc ''
        User account under which jellyfin-rpc runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "jellyfin-rpc";
      description = lib.mdDoc ''
        Group under which jellyfin-rpc runs.
      '';
    };

    jellyfin.url = mkOption {
      type = types.str;
      default = "https://example.com";
      description = ''
       Url to jellyfin server.
      '';
    };

    jellyfin.apiKey = mkOption {
      type = types.str;
      default = "sadasodsapasdskd";
      description = ''
        Jellyfin API key, you can get one at http(s)://your_jellyfin_url/web/#!/apikeys.html
      '';
    };

    jellyfin.username = mkOption {
      type = types.str;
      default = "my_user";
      description = ''
        Username used to log in to jellyfin.
      '';
    };

    discordApplicationID = mkOption {
      type = types.str;
      default = "1053747938519679018";
      description = ''
        Discord application ID, you can make one here https://discord.com/developers/applications
      '';
    };

    imgurClientID = mkOption {
      type = types.str;
      default = "asdjdjdg394209fdjs093";
      description = ''
        Imgur Client ID, goto https://api.imgur.com/oauth2/addclient
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.jellyfin-rpc;
      defaultText = literalExpression "pkgs.jellyfin-rpc";
      example = literalExpression "pkgs.jellyfin-rpc";
      description = ''
        Jellyfin-RPC derivation to use.
      '';
    };
  };

  config = mkIf cfg.enable {

    systemd.services.jellyfin-rpc = {
      description = "jellyfin-rpc service";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;

        ExecStart = "${cfg.package}/bin/jellyfin-rpc --config /etc/jellyfin-rpc/main.json";
      };
    };

    environment.etc."jellyfin-rpc/main.json".text = ''
      {
          "jellyfin": {
              "url": "${cfg.jellyfin.url}",
              "api_key": "${cfg.jellyfin.apiKey}",
              "username": ["${cfg.jellyfin.username}"],
              "music": {
                  "display": ["year", "album"]
              }
          },
          "discord": {
              "application_id": "${cfg.discordApplicationID}"
          },
          "imgur": {
              "client_id": "${cfg.imgurClientID}"
          },
          "images": {
              "enable_images": true,
              "imgur_images": true
          }
      }
    '';

    users.users = mkIf (cfg.user == "jellyfin-rpc") {
      jellyfin-rpc = {
        group = cfg.group;
        uid = UID;
      };
    };

    users.groups = mkIf (cfg.group == "jellyfin-rpc") {
      jellyfin-rpc = { gid = GID; };
    };
  };
  }

