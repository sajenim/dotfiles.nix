{config, ...}: {
  # Setup grafana our grafana instance.
  services.grafana = {
    enable = true;
    dataDir = "/srv/services/grafana";
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3400;
        domain = "kanto.dev";
        root_url = "https://kanto.dev/grafana/";
        serve_from_sub_path = true;
      };
      database = {
        type = "mysql";
        name = "grafana";
        user = "grafana";
        host = "/var/run/mysqld/mysqld.sock";
      };
    };
  };

  # Setup our database for grafana.
  services.mysql = {
    ensureUsers = [
      {
        name = "grafana";
        ensurePermissions = {
          "grafana.*" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = ["grafana"];
  };

  # Setup our traefik router.
  services.traefik.dynamicConfigOptions.http.routers = {
    grafana = {
      rule = "Host(`kanto.dev`)";
      entryPoints = [
        "websecure"
      ];
      middlewares = [
        "internal"
      ];
      service = "grafana";
    };
  };

  # Setup our traefik service.
  services.traefik.dynamicConfigOptions.http.services = {
    grafana.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";}
    ];
  };
}
