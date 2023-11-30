{ lib, pkgs, config, ... }:
with lib;                      
let
  cfg = config.services.jellyfin-rpc;
in {
  options.services.jellyfin-rpc = {
    enable = mkEnableOption "jellyfin-rpc service";
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
    home.packages = [ cfg.package ];
    xdg.configFile."jellyfin-rpc/main.json".text = ''
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
    systemd.user.services.jellyfin-rpc = {
      Unit = {
        Description = "Jellyfin-RPC";
      };
  
      Install = { WantedBy = [ "multi-user.target" ]; };
  
      Service = {
        ExecStart = concatStringsSep " " ([
          "${getExe cfg.package}"
          "--config ${config.xdg.configFile."jellyfin-rpc/main.json".source}"
        ]);
        Restart = "always";
        RestartSec = 3;
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ sajenim ];
}

